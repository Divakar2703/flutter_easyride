import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Pre_Booking/provider/preebooking_provider.dart';
import 'package:flutter_easy_ride/Pre_Booking/screens/select_prebooking_vehicle.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Book_Now/provider/cab_book_provider.dart';
import '../../book_easyride/custom/message.dart';
import '../../common_widget/custombutton.dart';
import '../../common_widget/map_widget.dart';
import '../../provider/map_provider.dart';
import '../../utils/eve.dart';

class SelectPickupTime extends StatefulWidget {
  @override
  _SelectPickupTimeState createState() => _SelectPickupTimeState();
}

class _SelectPickupTimeState extends State<SelectPickupTime> {
  DateTime? _selectedDate;
  String? _selectedTime;
  List<DateTime> _availableDates = [];
  Map<DateTime, List<String>> _availableTimes = {};

  static const LatLng _startLocation = LatLng(30.365368, 78.044571); // San Francisco

  @override
  void initState() {
    super.initState();

    final cabBookProvider = Provider.of<CabBookProvider>(context, listen: false);
    cabBookProvider.findDriver(9);

    // Provider.of<PreebookingProvider>(context, listen: false).confirmpreebook();

    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(ALatitude, ALongitude, dropLat, dropLong);
    mapProvider.getPolyPoints(ALatitude, ALongitude, dropLat, dropLong);
    _generateRandomAvailability(); // Generate random available dates and times
  }

  void _generateRandomAvailability() {
    Random random = Random();
    List<DateTime> upcomingDates = List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    setState(() {
      _availableDates = upcomingDates;
      for (DateTime date in upcomingDates) {
        List<String> timeSlots = List.generate(5, (index) {
          int hour = random.nextInt(12) + 9; // Random time between 9 AM - 9 PM
          String timeLabel = DateFormat('h:mm a').format(DateTime(0, 0, 0, hour, 0));
          return timeLabel;
        });
        _availableTimes[date] = timeSlots;
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

          // Draggable bottom sheet or fixed container for booking card
          Center(
            child: Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Pickup Time',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                      ),
                      SizedBox(height: 10),

                      // Date selection (Scrollable horizontal list)
                      Container(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _availableDates.length,
                          itemBuilder: (context, index) {
                            DateTime date = _availableDates[index];
                            String dayName = DateFormat('EEE').format(date); // Day (Mon, Tue, etc.)
                            String dateLabel = DateFormat('d MMM').format(date); // Date (12 Jul, etc.)
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDate = date;
                                  _selectedTime = null; // Reset time selection when changing date
                                });
                              },
                              child: Container(
                                width: 80,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: _selectedDate == date ? Colors.blue : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(dayName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: _selectedDate == date ? Colors.white : Colors.black,
                                            fontFamily: "Poppins")),
                                    SizedBox(height: 8),
                                    Text(dateLabel,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: _selectedDate == date ? Colors.white : Colors.black,
                                            fontFamily: "Poppins")),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 10),

                      // Time slots selector (Scrollable horizontal list)
                      _selectedDate != null
                          ? Container(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _availableTimes[_selectedDate]!.length,
                                itemBuilder: (context, index) {
                                  String time = _availableTimes[_selectedDate]![index];

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedTime = time;
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: _selectedTime == time ? Colors.blue : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          time,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: _selectedTime == time ? Colors.white : Colors.black,
                                              fontFamily: "poppins"),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text('Select a date to view available times'),
                            ),

                      Spacer(),

                      // Confirm Booking button
                      Center(
                        child: GestureDetector(
                            onTap: _selectedDate != null && _selectedTime != null
                                ? () {
                                    // Handle booking logic here
                                    Provider.of<PreebookingProvider>(context, listen: false);
                                    // .confirmpreebook();

                                    CustomSnackbar(
                                      message: 'Request has been send successfully',
                                      backgroundColor: Colors.blue,
                                      height: 35,
                                      widthFactor: 0.9,
                                      textStyle: TextStyle(color: Colors.white, fontSize: 15),
                                      durationInSeconds: 2,
                                    ).showSnackbar(context);
                                    child:
                                    Future.delayed(Duration(seconds: 3), () {
                                      Navigator.of(context).push(_createRoute());
                                    });

                                    print(
                                        'Booking for ${DateFormat('EEE, d MMM').format(_selectedDate!)} at $_selectedTime');
                                  }
                                : null,
                            child: Customtbutton(
                              text: "Confirm Booking",
                            )

                            // Text(
                            //   'Confirm Bookingm',
                            //   style: TextStyle(
                            //       fontFamily: "Poppins",
                            //       fontSize: 14,
                            //       color: Colors.white),
                            // ),
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: Color(0xff1937d7),
                            //   padding:
                            //       EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            //   textStyle: TextStyle(fontSize: 18, color: Colors.white),
                            // ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SelectPrebookingVehicle(),
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
