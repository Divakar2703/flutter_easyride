import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/payment/payment_Screen.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../book_easyride/new_screen/confirm_booking.dart';
import '../../common_widget/map_widget.dart';
import '../../model/driver_details.dart';
import '../../provider/map_provider.dart';
import '../../service/socket/socket_helper.dart';
import '../../service/socket/web_socket_service.dart';
import 'drive_looking_screen.dart';
import 'trip_details_screen.dart'; 

// class DriveFindingScreen extends StatefulWidget {
//   const DriveFindingScreen({super.key});
//
//   @override
//   State<DriveFindingScreen> createState() => _DriveFindingScreenState();
// }
//
// class _DriveFindingScreenState extends State<DriveFindingScreen> {
//   late GoogleMapController mapController;
//   final LatLng _pickupLocation = LatLng(ALatitude, ALongitude);
//   final WebSocketService _webSocketService = WebSocketService();
//   DriverDetails? _driverDetails;
//
//   @override
//   void initState() {
//     super.initState();
//     _webSocketService.connect();
//
//     // Listen to the driver details stream
//     _webSocketService.driverDetailsStream.listen((DriverDetails details) {
//       setState(() {
//         _driverDetails = details;
//       });
//     });
//     final cabBookProvider = Provider.of<CabBookProvider>(context, listen: false);
//     cabBookProvider.findDriver(9);
//
//     final mapProvider = Provider.of<MapProvider>(context, listen: false);
//     mapProvider.loadMapData(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
//     mapProvider.getPolyPoints(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mapProvider = Provider.of<MapProvider>(context);
//     final cabBookProvider=Provider.of<CabBookProvider>(context);
//
//
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           MapWidget(
//             initialPosition: _pickupLocation,
//             markers: mapProvider.markers,
//             polylineCoordinates: mapProvider.polylineCoordinates,
//           ),
//
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 500),
//               Padding(
//                 padding: EdgeInsets.only(left: 15),
//                 child: Row(
//                   children: [
//                     SizedBox(height: 50,),
//                     Text(
//                       cabBookProvider.driverInfo==null?
//                       'Looking for Driver':"Driver Info",
//                       style: TextStyle(fontFamily: "Poppins"),
//                     ),
//                     Spacer(),
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => TripDetailsScreen(),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(200),
//                           border: Border.all(width: 1, color: Colors.grey),
//                         ),
//                         child: Text(
//                           'Trip Details',
//                           style: TextStyle(fontFamily: "Poppins"),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Padding(
//               //   padding: EdgeInsets.only(left: 10, right: 10),
//               //   child: ProgressBar(),
//               // ),
//               SizedBox(height: 2),
//               cabBookProvider.driverInfo==null?
//                Shimmer.fromColors(
//                   baseColor: Colors.grey.shade300,
//                   highlightColor: Colors.grey.shade100,child: Divider(height: 2, thickness: 8)):Container(
//                 margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
//                 height: 220,
//                 width: double.infinity,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Scaffold(
//                     body: Container(
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 12),
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 25,
//                                   backgroundImage:
//                                   NetworkImage(cabBookProvider.driverInfo!.driverProfilePic),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       cabBookProvider.driverInfo!.driverName,
//                                       style: TextStyle(
//                                         fontSize: 17,
//                                         color: Colors.black87,
//                                         fontFamily:
//                                         'Poppins', // Set Poppins as the default font
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow,
//                                           size: 18,
//                                         ),
//                                         Text(
//                                           '4.7',
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             color: Colors.grey.shade600,
//                                             fontFamily:
//                                             'Poppins', // Set Poppins as the default font
//
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Spacer(),
//                                 CircleAvatar(
//                                   backgroundColor: Colors.green,
//                                   radius: 22,
//                                   child: Icon(
//                                     Icons
//                                         .call, // Replace Icons.person with the desired icon
//                                     size: 24,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Divider(
//                             thickness: 1,
//                           ),
//                           // Padding(
//                           //   padding: const EdgeInsets.symmetric(
//                           //       horizontal: 16, vertical: 12),
//                           //   child: Row(
//                           //     children: [
//                           //       CircleAvatar(
//                           //         radius: 15,
//                           //         backgroundImage:
//                           //         AssetImage('assets/images/user.jpeg'),
//                           //       ),
//                           //       SizedBox(
//                           //         width: 6,
//                           //       ),
//                           //       CircleAvatar(
//                           //         radius: 15,
//                           //         backgroundImage:
//                           //         AssetImage('assets/images/user.jpeg'),
//                           //       ),
//                           //       SizedBox(
//                           //         width: 6,
//                           //       ),
//                           //       CircleAvatar(
//                           //         radius: 15,
//                           //         backgroundImage:
//                           //         AssetImage('assets/images/user.jpeg'),
//                           //       ),
//                           //       SizedBox(
//                           //         width: 8,
//                           //       ),
//                           //       Text(
//                           //         '25 Recommended',
//                           //         style: TextStyle(
//                           //           fontSize: 15,
//                           //           fontFamily:
//                           //           'Poppins', // Set Poppins as the default font
//                           //
//                           //           color: Colors.black87,
//                           //           fontWeight: FontWeight.w400,
//                           //         ),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),
//                           // Divider(
//                           //   thickness: 1,
//                           // ),
//                           Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Image.network(
//                                   cabBookProvider.driverInfo!.vehicleImage,
//                                   width: 60,
//                                   height: 50,
//                                   //  color: selectedRow == index ? Colors.white : Colors.black87,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'DISTANCE',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontFamily:
//                                         'Poppins', // Set Poppins as the default font
//
//                                         color: Colors.grey.shade600,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Text(
//                                       cabBookProvider.driverInfo!.userJourneyDistance.toString(),
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontFamily:
//                                         'Poppins', // Set Poppins as the default font
//
//                                         color: Colors.black87,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'TIME',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontFamily:
//                                         'Poppins', // Set Poppins as the default font
//
//                                         color: Colors.grey.shade600,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Text(
//                                       '${cabBookProvider.driverInfo?.driverAway} min away',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontFamily:
//                                         'Poppins', // Set Poppins as the default font
//
//                                         color: Colors.black87,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'PRICE',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontFamily:
//                                         'Poppins', // Set Poppins as the default font
//
//                                         color: Colors.grey.shade600,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Text(
//                                       cabBookProvider.driverInfo!.totalFare.toString(),
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontFamily:
//                                         'Poppins', // Set Poppins as the default font
//
//                                         color: Colors.black87,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           Spacer(),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => ConfirmBooking()));
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(16),
//                               height: 44,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colors.blue),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//
//                                     },
//                                     child: Text(
//                                       "Next",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18.0,
//                                         fontFamily:
//                                         'Poppins', // Set Poppins as the default font
//
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';

class FindDriverScreen extends StatefulWidget {
  @override
  _FindDriverScreenState createState() => _FindDriverScreenState();
}

class _FindDriverScreenState extends State<FindDriverScreen> {
//  late final WebSocketHelper _webSocketService;
  final SocketHelper socketHelper = SocketHelper();

  @override
  void initState() {
    super.initState();
    socketHelper.connect();

    // Example: Call findDriver after connection
    socketHelper.findDriver(selectedVehicle, "15"); // Replace with actual IDs


    // _webSocketService = WebSocketHelper();
    // _webSocketService.connect();

// Send a request to find a driver
   // _webSocketService.findDriver(selectedVehicle, "15");
    // _webSocketService = DriverWebSocketService();
    // // Find driver with a sample vehicleTypeId and userId
    // _webSocketService.findDriver(10, 259); // Replace with actual IDs
  }



  @override
  Widget build(BuildContext context) {
    socketHelper.connect();

    return Scaffold(
      appBar: AppBar(title: Text('Find Driver')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<DriverDetails>(
            stream: socketHelper.driverDetailsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData) {
                return Center(child: Text("No driver data received"));
              } else {
                final driverDetails = snapshot.data!;
                return Center(
                  child: Text('Driver found: ${driverDetails.driverName}'), // Adjust based on DriverDetails fields
                );
              }
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              socketHelper.findDriver(selectedVehicle, "15"); // Replace with actual values
            },
            child: Text("Find Driver"),
          ),
        ],
      ),



    );
  }
}



