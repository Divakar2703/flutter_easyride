import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common_widget/driver_details_widget.dart';
import '../../common_widget/ride_details_card.dart';
import '../../model/booking.dart';
import '../../provider/map_provider.dart';
import '../../utils/eve.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../dashboard/dashboard_map.dart';


class MapTrackingScreen extends StatefulWidget {
  Booking booking;
  MapTrackingScreen({Key? key, required this.booking}) : super(key: key);

  @override
  _MapTrackingScreenState createState() => _MapTrackingScreenState();
}

class _MapTrackingScreenState extends State<MapTrackingScreen> {
  late GoogleMapController _mapController;
  late IO.Socket socket;

  // Booking Details
  final Map<String, dynamic> rideData = {
    "id": "57",
    "book_id": "Book-00741725",
    "booking_type": "book_now",
    "pickup_address": ", Anarwala, Dehradun, Uttarakhand, 248014",
    "drop_address": ", Hathibarkala, Dehradun, Uttarakhand, 248001",
    "user_journey_distance": "2.2",
    "total_fare": "26",
    "total_wait_charge": "0",
    "grand_total": "26.4",
    "paymenttype": "COD",
    "user_name": "Ankita Kanaujiya",
    "user_mobile": "7505145405",
    "user_email": "ankitakanaujiya@gmail.com",
    "pickup_lat": "30.3683644",
    "pickup_long": "78.0516538",
    "drop_lat": "30.348644013683",
    "drop_long": "78.052923046052",
    "ride_status": "Start",
    "payment_status": "Paid",
    "entry_date": "13/12/2024 14:39 PM"
  };
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
   LatLng _pickupLocation = LatLng(ALatitude, ALongitude);


  @override
  void initState() {
    super.initState();
    connectToSocket();
    final mapProvider = Provider.of<MapProvider>(context, listen: false);

    mapProvider.getPolyPoints(ALatitude, ALongitude, dropLat, dropLong);

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
    print("socket starting");
    socket.onConnect((_) {
      debugPrint('Connected to socket');
      sendConnection();
      trackDriverLocation();
    });

    socket.onDisconnect((_) => debugPrint('Socket disconnected'));
  }
  void sendConnection() {
    debugPrint('sendConnection');

    final jsonData = {'booking_id': widget.booking.id};
    print("jsondata======${jsonData}");
    socket.emit("joinBookingTracking", jsonEncode(jsonData));
  }

  void trackDriverLocation() {

    debugPrint('trackDriverLocation');

    socket.on("GetUpdatedLocation", (data) {
      print("data===${data}");
      try {
        //  final messageJson = jsonDecode(data);
        final messageJson = data is String ? json.decode(data) : data;
        final double latitude = double.parse(messageJson['latitude']);
        final double longitude = double.parse(messageJson['longitude']);
        final String isArrive = messageJson['is_arrive'].toString();
        final String isComplete = messageJson['is_complete'].toString();
        final String isStart = messageJson['is_start'].toString();

        print("driver lat==${latitude},log=${longitude}, Arrive==${isArrive}");

        final LatLng deliveryBoyLocation = LatLng(latitude,longitude);
        if (!mounted) return;
        setState(() {
          if (isArrive == "0") {
            Fluttertoast.showToast(msg: "Driver about to reach");
          //  _pickupLocation = LatLng(double.parse(widget.booking.pickup_lat), double.parse(widget.booking.pickup_lat));

            updateCurrentLocationMarkers(deliveryBoyLocation,LatLng(double.parse(widget.booking.pickup_lat), double.parse(widget.booking.pickup_long)));
            fetchDirectionsAndDrawPolyline(latitude,longitude,double.parse(widget.booking.pickup_lat), double.parse(widget.booking.pickup_long),isArrive);
          setState(() {

          });
          }


          if (isStart=="1"&&isComplete == "1" || isComplete == "0") {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (mounted) {
                Fluttertoast.showToast(msg: "Ride is completed");
                updateCurrentLocationMarkers(deliveryBoyLocation,LatLng(double.parse(widget.booking.drop_lat), double.parse(widget.booking.drop_long)));
                fetchDirectionsAndDrawPolyline(latitude,longitude,double.parse(widget.booking.drop_lat), double.parse(widget.booking.drop_long),isArrive);
              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardMap()));
                // Navigator.pushReplacementNamed(context, '/rideDetails', arguments: widget.bookingId);
              }
            });
          }

          //  updateCurrentLocationMarkers(userLocation,deliveryBoyLocation);
          // fetchDirectionsAndDrawPolyline(deliveryBoyLocation,userLocation,isArrive);
        });
      } catch (e) {
        debugPrint("Error processing message: $e");
      }
    });
  }
  void updateCurrentLocationMarkers(LatLng driverLocation, LatLng targetLocation) {
    final driverMarker = Marker(
      markerId: const MarkerId('driver_marker'),
      position: driverLocation,
      infoWindow: const InfoWindow(title: 'Driver Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    final targetMarker = Marker(
      markerId: const MarkerId('target_marker'),
      position: targetLocation,
      infoWindow: const InfoWindow(title: 'Target Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      _markers.clear();
      _markers.add(driverMarker);
      _markers.add(targetMarker);
    });
  }

  void fetchDirectionsAndDrawPolyline(double driverLat,double driverLong,  double userLat,double userLong ,String isArrive) async {
    try {
      print("lat==${driverLat} $driverLong,user==$userLat, $userLong");
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: "AIzaSyAKgqAyTO5G0rIf8laUc5_gOaF16Qwjg2Y",
          request: PolylineRequest(
              origin: PointLatLng(driverLat, driverLong),
              destination: PointLatLng(userLat, userLong),
              mode: TravelMode.driving));
      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        print("polycordingnates==${polylineCoordinates}");
setState(() {

});      }
      // if (result.points.isNotEmpty) {
      //   setState(() {
      //     _polylines.clear();
      //     _polylines.add(
      //       Polyline(
      //         polylineId: const PolylineId('route_polyline'),
      //         points: result.points
      //             .map((point) => LatLng(point.latitude, point.longitude))
      //             .toList(),
      //         color: Colors.blue,
      //         width: 5,
      //       ),
      //     );
      //   });
      // }
    } catch (error) {
      debugPrint("Error fetching polyline: $error");
    }
  }


  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target:LatLng(double.parse(widget.booking.pickup_lat), double.parse(widget.booking.pickup_long)),
              zoom: 14.0,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: _markers,
            polylines:{
              Polyline(
                polylineId: PolylineId('route'),
                points:
                [LatLng(30.368346, 78.0516573), LatLng(30.352049105084, 78.03386259824)],
               // polylineCoordinates,
                width: 3,
                color: Color(0xff1937d7),
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Bottom Sheet for Booking Details
          DraggableScrollableSheet(
            initialChildSize: 0.3, // Initial height
            minChildSize: 0.1, // Minimum height
            maxChildSize: 0.6, // Maximum height
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child:RideDetailsCard(
                    pickupLocation: widget.booking.pickupAddress,
                    dropLocation: widget.booking.dropAddress,
                    distance: widget.booking.userJourneyDistance,
                    totalFare: widget.booking.totalFare,
                    grandTotal: widget.booking.grandTotal,
                    rideStatus: widget.booking.rideStatus,
                    paymentType: widget.booking.paymentStatus,
                    isPaymentPending: widget.booking.paymentStatus=="Pending"?true:false,)
                ),
              );
            },
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: StylishDriverDetailsCard(
                driverEmail: widget.booking.driverEmail,
                driverMobileNo: widget.booking.driverMobileNo,
                driverGender: widget.booking.driverGender,
                 driverProfilePic: widget.booking.driverProfilePic,
                 driverRating: widget.booking.driverRating,
                drivername: widget.booking.driverName,
              ))
        ],
      ),
    );
  }


}
