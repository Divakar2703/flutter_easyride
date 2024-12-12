import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RideTrackingScreen extends StatefulWidget {
  final String bookingId;

  const RideTrackingScreen({Key? key, required this.bookingId}) : super(key: key);

  @override
  _RideTrackingScreenState createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {
  late IO.Socket socket;
  late GoogleMapController _mapController;
  Marker? userMarker;
  Marker? deliveryBoyMarker;
  LatLng dropLatLong = LatLng(0.0, 0.0); // Replace with actual drop location coordinates
  double userLatitude = 0.0;
  double userLongitude = 0.0;

  Set<Polyline> polylines = {}; // Store the polylines here

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.close();
    super.dispose();
  }

  void connectToSocket() {
    socket = IO.io('https://asatvindia.in:5001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      debugPrint('Connected to socket');
      sendConnection();
      trackDriverLocation();
    });

    socket.onDisconnect((_) => debugPrint('Socket disconnected'));
  }

  void sendConnection() {
    final jsonData = {'booking_id': widget.bookingId};
    socket.emit("joinBookingTracking", jsonEncode(jsonData));
  }

  void trackDriverLocation() {
    socket.on("GetUpdatedLocation", (data) {
      try {
        final messageJson = jsonDecode(data);
        final double latitude = double.parse(messageJson['latitude']);
        final double longitude = double.parse(messageJson['longitude']);
        final String isArrive = messageJson['is_arrive'];
        final String isComplete = messageJson['is_complete'];
        print("driver lat==${latitude},log=${longitude}");

        final LatLng deliveryBoyLocation = LatLng(latitude, longitude);

        if (!mounted) return;

        setState(() {
          if (isArrive == "1") {
            ALatitude = dropLatLong.latitude;
            ALongitude = dropLatLong.longitude;
            updateCurrentLocationMarker(dropLatLong, "User Location");
          }

          if (isComplete == "1" || isComplete == "2") {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/rideDetails', arguments: widget.bookingId);
              }
            });
          }

          updateCurrentLocationMarker(deliveryBoyLocation, "Delivery Boy Location");
          fetchDirectionsAndDrawPolyline(deliveryBoyLocation, isArrive);
        });
      } catch (e) {
        debugPrint("Error processing message: $e");
      }
    });
  }

  void updateCurrentLocationMarker(LatLng position, String locationName) {
    final markerId = locationName == "User Location" ? 'user_marker' : 'delivery_boy_marker';
    final newMarker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(title: locationName),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        locationName == "User Location" ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed,
      ),
    );

    setState(() {
      if (locationName == "User Location") {
        userMarker = newMarker;
      } else {
        deliveryBoyMarker = newMarker;
      }
    });
  }

  void fetchDirectionsAndDrawPolyline(LatLng deliveryBoyLocation, String isArrive) async {
    try {
      // Replace the existing polyline
      Polyline polyline = Polyline(
        polylineId: PolylineId("route"),
        color: Colors.blue,
        points: [
          deliveryBoyLocation,
          LatLng(userLatitude, userLongitude),
        ],
        width: 5,
      );

      setState(() {
        polylines.removeWhere((polyline) => polyline.polylineId.value == "route");
        polylines.add(polyline);
      });
    } catch (e) {
      debugPrint("Error fetching polyline: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ride Tracking")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(ALatitude, ALongitude),
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: {
          if (userMarker != null) userMarker!,
          if (deliveryBoyMarker != null) deliveryBoyMarker!,
        },
        polylines: polylines, // Use the updated Set<Polyline>
      ),
    );
  }
}
