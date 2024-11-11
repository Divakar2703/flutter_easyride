import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/rental/components/rental_booking_details_view.dart';
import 'package:flutter_easy_ride/rental/components/rentalbooking_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../common_widget/map_widget.dart';
import '../../provider/map_provider.dart';

class SelectRentalPackegeView extends StatefulWidget {
  @override
  _SelectRentalPackegeViewState createState() => _SelectRentalPackegeViewState();
}

class _SelectRentalPackegeViewState extends State<SelectRentalPackegeView> {
  String? _selectedDistance;
  String? _selectedDuration;
  String? _selectedCar;

  List<String> _availableDistances = [];
  Map<String, List<String>> _availableDurations = {};

  List<Map<String, dynamic>> _availableCars = [
    {
      'class': 'Blue Classic',
      'name': 'Sedan',
      'seats': '5',
      'rate': '50.00',
      "lessRate": '30.00',
      'image': 'assets/images/ride_car_two.png',
    },
    {
      'class': 'Blue Premium',
      'name': 'SUV',
      'seats': '2',
      'rate': '50.00',
      "lessRate": '30.00',
      'image': 'assets/images/ride_car_one.png',
    },
    {
      'class': 'Blue Classic',
      'name': 'Hatchback',
      'seats': '7',
      'rate': '50.00',
      "lessRate": '30.00',
      'image': 'assets/images/ride_car_three.png',
    },
  ];

  static const LatLng _startLocation = LatLng(30.365368, 78.044571);

  @override
  void initState() {
    super.initState();
    _fetchRentalAvailability();
  }

  void _fetchRentalAvailability() async {
    final prebookingProvider = Provider.of<RentalbookingProvider>(context, listen: false);
    try {
      // Assuming you have the required data for the API call
      await prebookingProvider.getRentalBooking(
        30.365368, // pickupLat
        78.044571, // pickupLong
        "user_web", // addedByWeb
        "Pickup Address", // pickupAddress
        "rental", // bookingType
        1, // userId
      );

      // After fetching data, update the UI
      setState(() {
        _availableDistances = prebookingProvider.rentalResponse?.km.map((km) => "$km km").toList() ?? [];
        _availableDurations = {
          for (int i = 0; i < _availableDistances.length; i++)
            _availableDistances[i]: prebookingProvider.rentalResponse?.hr.map((hr) => "$hr hr").toList() ?? []
        };
      });
    } catch (error) {
      print('Error fetching rental availability: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    final prebookingProvider = Provider.of<RentalbookingProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            initialPosition: _startLocation,
            markers: mapProvider.markers,
            polylineCoordinates: mapProvider.polylineCoordinates,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              height: MediaQuery.of(context).size.height * 0.67,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Distance, Duration & Car',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                  ),
                  SizedBox(height: 10),

                  // Distance selection
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.timelapse_rounded,
                            color: Color(0xff1937d7),
                            size: 18,
                          ),
                        ),
                      ),
                      Text(
                        "  Select a package",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _availableDistances.length,
                      itemBuilder: (context, index) {
                        String distance = _availableDistances[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDistance = distance;
                              _selectedDuration = null;
                              _selectedCar = null;
                            });
                          },
                          child: Container(
                            width: 80,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: _selectedDistance == distance ? Color(0xff1937d7) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                distance,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: _selectedDistance == distance ? Colors.white : Colors.black,
                                    fontFamily: "Poppins"
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  // Duration selection
                  _selectedDistance != null
                      ? Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _availableDurations[_selectedDistance]!.length,
                      itemBuilder: (context, index) {
                        String duration = _availableDurations[_selectedDistance]![index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDuration = duration;
                              _selectedCar = null;
                            });
                          },
                          child: Container(
                            width: 70,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: _selectedDuration == duration ? Color(0xff1937d7) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                duration,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: _selectedDuration == duration ? Colors.white : Colors.black,
                                    fontFamily: "Poppins"
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : Center(child: Text('Select a distance to view available durations')),

                  Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: _selectedDistance != null && _selectedDuration != null && _selectedCar != null
                          ? () async {
                        // Call the provider method
                        Navigator.of(context).push(_createRoute());
                      }
                          : null,
                      child: Text(
                        'Continue',
                        style: TextStyle(fontFamily: "Poppins", fontSize: 14, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1937d7),
                        padding: EdgeInsets.symmetric(horizontal: 72, vertical: 15),
                        textStyle: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RentalBookingDetailsView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
