import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/rental/components/rental_booking_details_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../common_widget/map_widget.dart';
import '../../provider/map_provider.dart';
import '../../utils/eve.dart';

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

  // Car list with name, rate, and image (local or network)
  List<Map<String, dynamic>> _availableCars = [
    {
      'class': 'Blue Classic',
      'name': 'Sedan',
      'seats':'5',
      'rate': '50.00',
      "lessRate": '30.00',
      'image': 'assets/images/ride_car_two.png',
    },
    {
      'class': 'Blue Premium',
      'name': 'SUV',
      'seats':'2',
      'rate': '50.00',
      "lessRate": '30.00',
      'image': 'assets/images/ride_car_one.png',
    },
    {
      'class': 'Blue Classic',
      'name': 'Hatchback',
      'seats':'7',
      'rate': '50.00',
      "lessRate": '30.00',
      'image': 'assets/images/ride_car_three.png',
    },
  ];

  static const LatLng _startLocation = LatLng(30.365368, 78.044571);

  @override
  void initState() {
    super.initState();
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    mapProvider.getPolyPoints(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    _generateRandomAvailability();
  }

  void _generateRandomAvailability() {
    Random random = Random();
    List<String> distances = ['10km', '20km', '30km', '40km', '50km'];

    setState(() {
      _availableDistances = distances;
      for (String distance in distances) {
        List<String> durationSlots = List.generate(5, (index) {
          int hour = random.nextInt(5) + 1; // Random duration between 1hr - 5hr
          return "${hour}hr";
        });
        _availableDurations[distance] = durationSlots;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

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
              height: MediaQuery.of(context).size.height * 0.67, // Adjusted height for car list
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
                            color: Colors.grey.shade300, // Change this to your desired border color
                            width: 1.0, // Change the width as needed
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white, // Change this to your desired background color
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
                                distance ,
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


                  SizedBox(height: 10),
                  Row(
                    //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300, // Change this to your desired border color
                            width: 1.0, // Change the width as needed
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white, // Change this to your desired background color
                          child: Icon(
                            Icons.car_crash_outlined,
                            color: Color(0xff1937d7),
                            size: 18,
                          ),
                        ),
                      ),
                      Text(
                        "  Select category",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  // Car selection (shown after duration is selected)
                  _selectedDuration != null
                      ? Container(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _availableCars.length,
                      itemBuilder: (context, index) {
                        var car = _availableCars[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCar = car['name'];
                            });
                          },
                          child: Container(
                            width: 140,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedCar == car['name'] ? Color(0xff1937d7) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Car image
                                Image.asset(
                                  car['image'],
                                  height: 70,
                                  width: 120,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      car['class'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedCar == car['name'] ? Colors.white : Color(0xff1937d7), // Change here
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      car['name'],
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: _selectedCar == car['name'] ? Colors.white : Colors.black,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(
                                      Icons.person_sharp,
                                      size: 14,
                                      color: _selectedCar == car['name'] ? Colors.white : Colors.black,
                                    ),
                                    Text(
                                      car['seats'],
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: _selectedCar == car['name'] ? Colors.white : Colors.black,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee_rounded,
                                      size: 14,
                                      color: _selectedCar == car['name'] ? Colors.white : Colors.green.shade700,
                                    ),
                                    Text(
                                      car['rate'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedCar == car['name'] ? Colors.white : Colors.green.shade700,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      car['lessRate'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedCar == car['name'] ? Colors.white : Colors.black,
                                        fontFamily: 'Poppins',
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.black54,
                                        decorationThickness: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : Container(),

                  Spacer(),

                  // Confirm Booking button
                  Center(
                    child: ElevatedButton(
                      onPressed: _selectedDistance != null && _selectedDuration != null && _selectedCar != null
                          ? () {
                        Navigator.of(context).push(_createRoute());
                        print('Booking for $_selectedDistance at $_selectedDuration with $_selectedCar');
                      }
                          : null, // Disable button if all selections are not made
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
        const begin = Offset(1.0, 0.0); // Start off the screen to the right
        const end = Offset.zero; // Slide to the center
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
