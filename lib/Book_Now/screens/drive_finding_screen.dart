import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../book_easyride/new_screen/confirm_booking.dart';
import '../../common_widget/map_widget.dart';
import '../../provider/map_provider.dart';
import 'trip_details_screen.dart';

class DriveFindingScreen extends StatefulWidget {
  const DriveFindingScreen({super.key});

  @override
  State<DriveFindingScreen> createState() => _DriveFindingScreenState();
}

class _DriveFindingScreenState extends State<DriveFindingScreen> {
  late GoogleMapController mapController;
  final LatLng _pickupLocation = LatLng(ALatitude, ALongitude);

  @override
  void initState() {
    super.initState();

    final cabBookProvider =
        Provider.of<CabBookProvider>(context, listen: false);
    cabBookProvider.findDriver(9);

    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(
        ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    mapProvider.getPolyPoints(
        ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    final cabBookProvider = Provider.of<CabBookProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            initialPosition: _pickupLocation,
            markers: mapProvider.markers,
            polylineCoordinates: mapProvider.polylineCoordinates,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 500),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      cabBookProvider.driverInfo == null
                          ? 'Looking for Driver'
                          : "Driver Info",
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripDetailsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: Text(
                          'Trip Details',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
                ),
              ),
              SizedBox(height : 5),
              cabBookProvider.driverInfo == null
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Divider(height: 2, thickness: 8))
                  : Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                      height: 220,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Scaffold(
                          body: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            cabBookProvider
                                                .driverInfo!.driverProfilePic),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cabBookProvider
                                                .driverInfo!.driverName,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black87,
                                              fontFamily:
                                                  'Poppins', // Set Poppins as the default font
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18,
                                              ),
                                              Text(
                                                '4.7',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade600,
                                                  fontFamily:
                                                      'Poppins', // Set Poppins as the default font

                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 22,
                                        child: Icon(
                                          Icons
                                              .call, // Replace Icons.person with the desired icon
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 16, vertical: 12),
                                //   child: Row(
                                //     children: [
                                //       CircleAvatar(
                                //         radius: 15,
                                //         backgroundImage:
                                //         AssetImage('assets/images/user.jpeg'),
                                //       ),
                                //       SizedBox(
                                //         width: 6,
                                //       ),
                                //       CircleAvatar(
                                //         radius: 15,
                                //         backgroundImage:
                                //         AssetImage('assets/images/user.jpeg'),
                                //       ),
                                //       SizedBox(
                                //         width: 6,
                                //       ),
                                //       CircleAvatar(
                                //         radius: 15,
                                //         backgroundImage:
                                //         AssetImage('assets/images/user.jpeg'),
                                //       ),
                                //       SizedBox(
                                //         width: 8,
                                //       ),
                                //       Text(
                                //         '25 Recommended',
                                //         style: TextStyle(
                                //           fontSize: 15,
                                //           fontFamily:
                                //           'Poppins', // Set Poppins as the default font
                                //
                                //           color: Colors.black87,
                                //           fontWeight: FontWeight.w400,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Divider(
                                //   thickness: 1,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        cabBookProvider
                                            .driverInfo!.vehicleImage,
                                        width: 60,
                                        height: 50,
                                        //  color: selectedRow == index ? Colors.white : Colors.black87,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'DISTANCE',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily:
                                                  'Poppins', // Set Poppins as the default font

                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            cabBookProvider
                                                .driverInfo!.userJourneyDistance
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily:
                                                  'Poppins', // Set Poppins as the default font

                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'TIME',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily:
                                                  'Poppins', // Set Poppins as the default font

                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${cabBookProvider.driverInfo?.driverAway} min away',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily:
                                                  'Poppins', // Set Poppins as the default font
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'PRICE',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily:
                                                  'Poppins', // Set Poppins as the default font
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            cabBookProvider
                                                .driverInfo!.totalFare
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily:
                                                  'Poppins',
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmBooking()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    height: 44,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            "Next",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontFamily:
                                                  'Poppins', // Set Poppins as the default font
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 100),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmBooking()));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
