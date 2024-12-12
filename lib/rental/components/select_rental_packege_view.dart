import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/rental/components/rental_booking_details_view.dart';
import 'package:flutter_easy_ride/rental/components/rentalbooking_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common_widget/custombutton.dart';
import '../get_rental_vehical_provider.dart';

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

  List<Map<String, dynamic>> _availableCars = [ {
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
    },];

  static const LatLng _startLocation = LatLng(30.365368, 78.044571);

  @override
  void initState() {
    super.initState();
    _fetchRentalAvailability();
  }

  void _fetchRentalAvailability() async {
    final prebookingProvider = Provider.of<RentalbookingProvider>(context, listen: false);
    final vehicleProvider = Provider.of<GetRentalVehicleProvider>(context, listen: false);

    try {
      await prebookingProvider.getRentalBooking(
        30.365368,
        78.044571,
        "user_web",
        "Pickup Address",
        "rental",
        1,
      );

      await vehicleProvider.getRentalVehicle(30.365368, 78.044571, 3, 10);

      setState(() {
        _availableDistances = prebookingProvider.rentalResponse?.km.map((km) => "$km km").toList() ?? [];
        _availableDurations = {
          for (int i = 0; i < _availableDistances.length; i++)
            _availableDistances[i]: prebookingProvider.rentalResponse?.hr.map((hr) => "$hr hr").toList() ?? []
        };

        _availableCars = vehicleProvider.getRentalVehicleResponse?.vehicles.map((vehicle) {
          return {
            'class': vehicle.type,
            'name': vehicle.name,
            'seats': 'N/A', // Replace with actual seat count if available
            'rate': vehicle.netFare.toString(),
            'lessRate': vehicle.fare.toString(),
            'image': vehicle.image,
          };
        }).toList() ?? [];
      });
    } catch (error) {
      print('Error fetching rental availability: $error');
    }
  }

  void _fetchRentalVehicle() async {
    final vehicleProvider = Provider.of<GetRentalVehicleProvider>(context, listen: false);

    try {
      await vehicleProvider.getRentalVehicle(
        30.36581490852199,
        78.04388081621565,
        1,
        20,
      );

      // await vehicleProvider.getRentalVehicle(30.365368, 78.044571, 3, 10);

      setState(() {

        _availableCars = vehicleProvider.getRentalVehicleResponse?.vehicles.map((vehicle) {
          return {
            'class': vehicle.type,
            'name': vehicle.name,
            'seats': 'N/A', // Replace with actual seat count if available
            'rate': vehicle.netFare.toString(),
            'lessRate': vehicle.fare.toString(),
            'image': vehicle.image,
          };
        }).toList() ?? [];
      });
    } catch (error) {
      print('Error fetching rental availability: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map background
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _startLocation, zoom: 14.0),
            markers: Set.from([]), // Add markers if necessary
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
                      Icon(Icons.timelapse_rounded, color: Color(0xff1937d7), size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Select a package",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
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
                      itemCount: _availableDurations[_selectedDistance]?.length ?? 0,
                      itemBuilder: (context, index) {
                        String duration = _availableDurations[_selectedDistance]![index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDuration = duration;
                              _selectedCar = null;
                              _fetchRentalVehicle();
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
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : SizedBox.shrink(),

                  // Car selection
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
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedCar == car['name'] ? Color(0xff1937d7) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(car['image'], height: 70, width: 120),
                                Text(
                                  car['class'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _selectedCar == car['name'] ? Colors.white : Color(0xff1937d7),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(car['name'], style: TextStyle(fontSize: 11)),
                                    SizedBox(width: 6),
                                    Icon(Icons.person, size: 14),
                                    Text(car['seats'], style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("₹ ${car['rate']}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                    SizedBox(width: 8),
                                    Text("₹ ${car['lessRate']}", style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                     : SizedBox.shrink(),

                  Spacer(),
                  Center(
                    child: GestureDetector(
                      onTap: _selectedDistance != null && _selectedDuration != null && _selectedCar != null
                          ? () {
                        Navigator.of(context).push(_createRoute());
                      }
                          : null,
                      child: Customtbutton(
                        text: "Continue",

                      )
                      // Text(
                      //   'Continue',
                      //   style: TextStyle(fontSize: 14, color: Colors.white),
                      // ),
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Color(0xff1937d7),
                      //   padding: EdgeInsets.symmetric(horizontal: 72, vertical: 15),
                      // ),
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
