import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/view/dashboard/dashboard_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../Book_Now/common_widget/shimmer_loader.dart';
import '../../common_widget/map_widget.dart';
import '../../provider/map_provider.dart';

class RideTrackingScreen extends StatefulWidget {
  final String bookingId;
  final String drop_lat;
  final String drop_long;

   RideTrackingScreen({Key? key, required this.bookingId,required this.drop_lat, required this.drop_long}) : super(key: key);

  @override
  _RideTrackingScreenState createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {
  PolylinePoints polylinePoints = PolylinePoints();
  late IO.Socket socket;
  late GoogleMapController _mapController;
  Marker? userMarker;
  Marker? deliveryBoyMarker;
  LatLng dropLatLong = LatLng(0.0, 0.0); // Replace with actual drop location coordinates
  double userLatitude = 0.0;
  double userLongitude = 0.0;
  List<LatLng> polylineCoordinates = [];
  final LatLng _pickupLocation = LatLng(ALatitude, ALongitude); // Pickup location coordinates


  Set<Polyline> polylines = {}; // Store the polylines here

  @override
  void initState() {
    super.initState();
    final mapProvider = Provider.of<MapProvider>(context, listen: false);

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
    debugPrint('sendConnection');

    final jsonData = {'booking_id': widget.bookingId};
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
        print("driver lat==${latitude},log=${longitude}, Arrive==${isArrive}");

        final LatLng deliveryBoyLocation = LatLng(latitude,longitude);
        final LatLng userLocation = LatLng(ALatitude,ALongitude);
        if (!mounted) return;
        setState(() {
          if (isArrive == "0") {
            ALatitude = dropLatLong.latitude;
            ALongitude = dropLatLong.longitude;
            print("dropdrop====${widget.drop_lat},${widget.drop_long}");
            updateCurrentLocationMarkers(deliveryBoyLocation,LatLng(double.parse(widget.drop_lat), double.parse(widget.drop_long)));
            fetchDirectionsAndDrawPolyline(deliveryBoyLocation,LatLng(double.parse(widget.drop_lat), double.parse(widget.drop_long)),isArrive);
          }

          if (isComplete == "1" || isComplete == "2") {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (mounted) {
                Fluttertoast.showToast(msg: "Ride is completed");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardMap()));
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

  void updateCurrentLocationMarkers(LatLng userPosition, LatLng deliveryBoyPosition) {
    print("userlocation ===${userPosition}");
    final userMarker = Marker(
      markerId: const MarkerId('user_marker'),
      position: userPosition,
      infoWindow: const InfoWindow(title: 'User Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    final deliveryBoyMarker = Marker(
      markerId: const MarkerId('delivery_boy_marker'),
      position: deliveryBoyPosition,
      infoWindow: const InfoWindow(title: 'Delivery Boy Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    setState(() {
      this.userMarker = userMarker;
      this.deliveryBoyMarker = deliveryBoyMarker;
    });
  }

  Future<void> getPolyPoints(double originLat, double originLng, double destLat, double destLng) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: "AIzaSyAKgqAyTO5G0rIf8laUc5_gOaF16Qwjg2Y",
          request: PolylineRequest(
              origin: PointLatLng(ALatitude, ALongitude),
              destination: PointLatLng(dropLat, dropLong),
              mode: TravelMode.driving));

      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        setState(() {

        });
      }
    } catch (error) {
      print("Error getting route: $error");
    }
  }


  void fetchDirectionsAndDrawPolyline(LatLng deliveryBoyLocation,LatLng userlocation, String isArrive) async {
    try {
      // Replace the existing polyline
      Polyline polyline = Polyline(
        polylineId: PolylineId("route"),
        color: Colors.blue,
        points: [
          deliveryBoyLocation,
          userlocation,
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
    final mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Ride Tracking")),
      body:

      // mapProvider.isLoading
      //     ? ShimmerLoader()
      //     : Stack(
      //   children: [
      //     MapWidget(
      //       initialPosition: _pickupLocation,
      //       markers: mapProvider.markers,
      //       polylineCoordinates: mapProvider.polylineCoordinates,
      //     ),
      //     // Draggable bottom sheet or fixed container for booking card
      //
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Container(
      //         padding: const EdgeInsets.all(16.0),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius:
      //           BorderRadius.vertical(top: Radius.circular(30)),
      //           boxShadow: [
      //             BoxShadow(color: Colors.black12, blurRadius: 10)
      //           ],
      //         ),
      //         height: MediaQuery.of(context).size.height * 0.5,
      //         child: SingleChildScrollView(
      //           child: Column(
      //             children: [
      //               Container(
      //                 height: MediaQuery.of(context).size.height * 0.35,
      //                 padding: EdgeInsets.symmetric(
      //                     vertical: 16, horizontal: 16),
      //                 decoration: const BoxDecoration(
      //                   borderRadius: BorderRadius.only(
      //                     topRight: Radius.circular(16),
      //                     topLeft: Radius.circular(16),
      //                   ),
      //                   color: Colors.white,
      //                 ),
      //                 child: Consumer<CabBookProvider>(
      //                     builder: (context, cabProvider, child) {
      //                       if (cabProvider.vehicleResponse == null) {
      //                         return Center(
      //                             child: Text("No vehicles available"));
      //                       } else if (cabProvider.vehicleResponse!.vehicle ==
      //                           null ||
      //                           cabProvider
      //                               .vehicleResponse!.vehicle!.isEmpty) {
      //                         return Center(
      //                             child: Text("No vehicles available"));
      //                       } else {
      //                         return ListView.builder(
      //                           shrinkWrap: true,
      //                           itemCount: cabProvider
      //                               .vehicleResponse?.vehicle.length,
      //                           itemBuilder:
      //                               (BuildContext context, int index) {
      //                             var vehicle = cabProvider
      //                                 .vehicleResponse?.vehicle[index];
      //
      //                             return VehicleListItem(
      //                               title: vehicle!.name,
      //                               subtitle: vehicle.description,
      //                               price: vehicle.fare.toString(),
      //                               time: "2 min",
      //                               assetPath: vehicle.image,
      //                               isSelected: selectedRows.contains(
      //                                   index), // Check if the current index is in the selected rows
      //                               onTap: () {
      //
      //                                 setState(() {
      //                                   selectedVehicle=vehicle.id;
      //                                   setState(() {
      //                                   });
      //                                   // Toggle the selection state
      //                                   if (selectedRows.contains(index)) {
      //                                     selectedRows.remove(
      //                                         index); // Deselect if already selected
      //                                   } else {
      //                                     cabProvider.getOffers(
      //                                         int.parse(vehicle.id));
      //                                     selectedRows.add(
      //                                         index); // Select if not selected
      //                                     cabProvider.sendRequestToDriver(vehicle.id,"book_now");
      //                                   }
      //                                 });
      //                               },
      //                             );
      //                           },
      //                         );
      //                       }
      //                     }),
      //               ),
      //
      //               // Confirm Button
      //               Container(
      //                 width: MediaQuery.of(context).size.width,
      //                 height: 100,
      //                 padding: EdgeInsets.all(10),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(10),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: Colors.black
      //                           .withOpacity(0.2), // Shadow color
      //                       offset: Offset(0,
      //                           -4), // Offset with negative y value for top shadow
      //                       blurRadius: 6, // Blur radius
      //                       spreadRadius: 1, // Spread radius
      //                     ),
      //                   ],
      //                 ),
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment:
      //                       MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         InkWell(
      //                           onTap: () => _showPaymentMethodBottomSheet(context),
      //                           child: Container(
      //                             width: MediaQuery.of(context).size.width *
      //                                 0.4,
      //                             child: Row(
      //                               mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Row(
      //                                   children: [
      //                                     Icon(
      //                                       Icons.payment,
      //                                       color: Colors.green,
      //                                     ),
      //                                     SizedBox(
      //                                       width: 5,
      //                                     ),
      //                                     Text("$selectedPaymentMethod"),
      //                                   ],
      //                                 ),
      //
      //                                 Icon(
      //                                   Icons.arrow_forward_ios_rounded,
      //                                   color: Colors.black,
      //                                   size: 18,
      //                                 )
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                         Container(
      //                           height: 25,
      //                           width: 2,
      //                           color: Colors.grey.shade200,
      //                         ),
      //                         InkWell(
      //                           onTap: ()=> openPromocodeBottomSheet(context),
      //
      //                           child: Container(
      //                             width: MediaQuery.of(context).size.width *
      //                                 0.4,
      //                             child: Row(
      //                               mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Row(
      //                                   children: [
      //                                     Icon(
      //                                       Icons.local_offer_sharp,
      //                                       color: Colors.blueAccent,
      //                                     ),
      //                                     SizedBox(
      //                                       width: 5,
      //                                     ),
      //                                     Text("Offers"),
      //                                   ],
      //                                 ),
      //                                 Icon(
      //                                   Icons.arrow_forward_ios_rounded,
      //                                   color: Colors.black,
      //                                   size: 18,
      //                                 )
      //                               ],
      //                             ),
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     Consumer<CabBookProvider>(
      //                       builder: (BuildContext context, provider, Widget? child) {
      //                         return GestureDetector(
      //                           onTap: () {
      //                             if(selectedVehicle!=""){
      //                               socketHelper.connect();
      //                               socketHelper.findDriver(selectedVehicle, "15"); // Replace with actual IDs
      //                               // Provider.of<CabBookProvider>(context, listen: false).sendRequestToDriver();
      //                               Provider.of<CabBookProvider>(context, listen: false).paynow(provider.bookingReq!.reqId,"COD",0);
      //                               Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmBooking()));
      //                             }
      //                             else{
      //                               Fluttertoast.showToast(msg: "Please Select the vehicle");
      //                             }
      //
      //
      //                             // Add your confirm action here
      //                             // Navigator.push(context, MaterialPageRoute(builder: (context) => FindDriverScreen()));
      //                           },
      //                           child: Container(
      //                             width: MediaQuery.of(context).size.width,
      //                             height: 44,
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(10),
      //                               color: Color(
      //                                   0xff1937d7), // Your confirm button color
      //                             ),
      //                             child: const Center(
      //                               child: Text(
      //                                 "Confirm",
      //                                 style: TextStyle(
      //                                   color: Colors.white,
      //                                   fontFamily: 'Poppins',
      //                                   fontSize: 18.0,
      //                                   fontWeight: FontWeight.w500,
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         );
      //                       },
      //
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),



      GoogleMap(
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
