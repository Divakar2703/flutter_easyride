import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/provider/map_provider.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../common_widget/custombutton.dart';
import '../provider/cab_book_provider.dart';
import 'drive_looking_screen.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  late GoogleMapController mapController;
  final LatLng _pickupLocation = LatLng(ALatitude, ALongitude);

  @override
  void initState() {
    super.initState();

    final cabBookProvider =
        Provider.of<CabBookProvider>(context, listen: false);
    cabBookProvider.getVehicleData();

    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(
        ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    mapProvider.getPolyPoints(
        ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Looking for',
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      Text(
                        'Bike ride',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ProgressBar()),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                thickness: 8,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.green,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '151',
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      Text(
                        'Block A, New Ashok Nagar, New Delhi ',
                        style: TextStyle(fontFamily: "Poppins"),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sector 63',
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      Text(
                        'Noida Uttar Pradesh',
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 8,
                height: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Fare',
                          style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          width: 230,
                        ),
                        Text(
                          ' ₹ 100',
                          style: TextStyle(fontFamily: "Poppins"),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Customtbutton(
                  text: 'Back',
                  fontFamily: "Poppins",
                  textColor: Colors.black,
                  color: Colors.yellow,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Customtbutton(
                  fontFamily: "Poppins",
                  color: Colors.red,
                  text: 'Cancel Ride',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_easy_ride/provider/map_provider.dart';
// import 'package:flutter_easy_ride/utils/eve.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';

// import '../../common_widget/custombutton.dart';
// import '../provider/cab_book_provider.dart';
// import 'drive_looking_screen.dart';

// class TripDetailsScreen extends StatefulWidget {
//   const TripDetailsScreen({super.key});

//   @override
//   State<TripDetailsScreen> createState() => _TripDetailsScreenState();
// }

// class _TripDetailsScreenState extends State<TripDetailsScreen> {
//   late GoogleMapController mapController;
//   final LatLng _pickupLocation = LatLng(ALatitude, ALongitude); // Define your pickup coordinates here

//   @override
//   void initState() {
//     super.initState();
//     final cabBookProvider = Provider.of<CabBookProvider>(context, listen: false);
//     cabBookProvider.getVehicleData();

//     final mapProvider = Provider.of<MapProvider>(context, listen: false);
//     mapProvider.loadMapData(
//         ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
//     mapProvider.getPolyPoints(
//         ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mapProvider = Provider.of<MapProvider>(context);

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Google Map section
//           Container(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _pickupLocation,
//                 zoom: 14.0,
//               ),
//               markers: mapProvider.markers,
//               // polylines: mapProvider.polylines,
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//             ),
//           ),
//           // UI overlay on top of the map
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
              
//               Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Looking for',
//                       style: TextStyle(fontFamily: "Poppins"),
//                     ),
//                     Text(
//                       'Bike ride',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontFamily: "Poppins",
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Padding(
//                 padding: EdgeInsets.only(left: 10, right: 10),
//                 child: ProgressBar(), // Placeholder for your progress bar widget
//               ),
//               SizedBox(height: 20),
//               Divider(height: 2, thickness: 8),
//               SizedBox(height: 20),
//               // Pickup Address
//               Row(
//                 children: [
//                   SizedBox(width: 10),
//                   Icon(Icons.location_on, color: Colors.green),
//                   SizedBox(width: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('151', style: TextStyle(fontFamily: "Poppins")),
//                       Text('Block A, New Ashok Nagar, New Delhi ', style: TextStyle(fontFamily: "Poppins")),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               // Drop-off Address
//               Row(
//                 children: [
//                   SizedBox(width: 10),
//                   Icon(Icons.location_on, color: Colors.red),
//                   SizedBox(width: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Sector 63', style: TextStyle(fontFamily: "Poppins")),
//                       Text('Noida Uttar Pradesh', style: TextStyle(fontFamily: "Poppins")),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Divider(thickness: 8, height: 2),
//               SizedBox(height: 20),
//               // Total Fare
//               Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Row(
//                   children: [
//                     Text('Total Fare', style: TextStyle(fontSize: 15, fontFamily: "Poppins")),
//                     Spacer(),
//                     Text('₹ 100', style: TextStyle(fontFamily: "Poppins")),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Back Button
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Customtbutton(
//                   text: 'Back',
//                   fontFamily: "Poppins",
//                   textColor: Colors.black,
//                   color: Colors.yellow,
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Cancel Ride Button
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Customtbutton(
//                   fontFamily: "Poppins",
//                   color: Colors.red,
//                   text: 'Cancel Ride',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // // Placeholder for ProgressBar widget
// // class ProgressBar extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return LinearProgressIndicator(); // Simple progress bar
// //   }
// // }

