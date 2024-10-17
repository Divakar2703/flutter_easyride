import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../common_widget/map_widget.dart';
import '../../provider/map_provider.dart';
import '../../utils/eve.dart';
import 'booking_details_screen.dart';

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
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    mapProvider.getPolyPoints(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
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

          MapWidget(initialPosition: _startLocation, markers: mapProvider.markers, polylineCoordinates: mapProvider.polylineCoordinates,),

          // Draggable bottom sheet or fixed container for booking card
          Align(
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
                    'Select Pickup Time ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontFamily: "Poppins"),
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
                              color: _selectedDate == date ?  Color(0xff1937d7) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(dayName, style: TextStyle(fontSize: 14, color: _selectedDate == date ? Colors.white : Colors.black,fontFamily: "Poppins")),
                                SizedBox(height: 8),
                                Text(dateLabel, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _selectedDate == date ? Colors.white : Colors.black,fontFamily: "Poppins")),
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
                              color: _selectedTime == time ?  Color(0xff1937d7) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                time,
                                style: TextStyle(fontSize: 14, color: _selectedTime == time ? Colors.white : Colors.black,fontFamily: "poppins"),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : Center(child: Text('Select a date to view available times')),

                  Spacer(),

                  // Confirm Booking button
                  Center(
                    child: ElevatedButton(
                      onPressed: _selectedDate != null && _selectedTime != null
                          ? () {
                        // Handle booking logic here
                        Navigator.of(context).push(_createRoute());

                        print('Booking for ${DateFormat('EEE, d MMM').format(_selectedDate!)} at $_selectedTime');
                        // Navigate or send data to backend for booking
                      }
                          : null, // Disable button if date and time not selected
                      child: Text('Confirm Booking',style: TextStyle(fontFamily: "Poppins",fontSize: 14,color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1937d7),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18,color: Colors.white),
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
      pageBuilder: (context, animation, secondaryAnimation) => BookingDetailsScreen(),
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
