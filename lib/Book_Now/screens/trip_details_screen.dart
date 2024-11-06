import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/provider/map_provider.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Pre_Booking/provider/preebooking_provider.dart';
import '../../common_widget/custombutton.dart';
import '../../common_widget/map_widget.dart';
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

    // final cancelPreeboovehicle = Provider.of<PreebookingProvider>(context);
    // cancelPreeboovehicle.Cancialpreebook();

    Provider.of<PreebookingProvider>(context, listen: false);

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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MapWidget(
                    initialPosition: _pickupLocation,
                    markers: mapProvider.markers,
                    polylineCoordinates: mapProvider.polylineCoordinates,
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
                    height: 5,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ProgressBar()),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 2,
                    thickness: 8,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
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
                    height: 15,
                  ),
                  Divider(
                    thickness: 8,
                    height: 2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total Fare',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "Poppins"),
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
                        textColor: Colors.white,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: InkWell(
                      onTap: () {
                        Provider.of<PreebookingProvider>(context, listen: false)
                            .Cancialpreebook(
                               "Book-00075307", "plan changed", 8238375356);
                      },
                      child: Customtbutton(
                        fontFamily: "Poppins",
                        color: Colors.blue,
                        text: 'Cancel Ride',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
