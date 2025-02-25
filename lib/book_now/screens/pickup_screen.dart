import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/Book_Now/screens/select_vehicle.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../common_widget/custombutton.dart';
import '../../common_widget/pickup_drop_widget.dart';
import '../../view/map/map_screen.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  bool isPickup = false;
  @override
  void initState() {
    super.initState();
    print("address=$address");
    _getCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CabBookProvider>(context, listen: false).getCurrentLocation();
    });
  }

  @override
  void dispose() {
    pickupController.dispose();
    dropController.dispose();
    super.dispose();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Retrieve the address for the current location
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        ALatitude = position.latitude;
        ALongitude = position.longitude;
        address =
            '${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
        pickupController.text = address;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cabProvider = Provider.of<CabBookProvider>(context);
    // if (pickupController.text == "" && pickupController.text==address) {
    //
    //   pickupController.text = cabProvider.pickupLocation!;
    // }
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Pickup',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins', // Set Poppins as the default font
              fontSize: 17,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 21,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          PickupDropWidget(
            onPickupTap: () {
              pickupController.clear();
              isPickup = true;
              setState(() {});
            },
            pickupController: pickupController,
            dropController: dropController,

            // onChange for Pickup
            onPickupChange: (value) {
              setState(() {
                pickupController.text = value; // Update pickup text
                cabProvider.placeAutoComplete(value, "Pickup");
                print('Pickup location: $value');
                // cabProvider.placeAutoComplete(value, "Pickup");
              });
            },
            onDropTap: () {
              isPickup = false;
              dropController.clear();
              setState(() {});
            },

            // onChange for Drop
            onDropChange: (value) {
              setState(() {
                dropController.text = value; // Update drop text
                // Call your autoComplete function for Drop
                cabProvider.placeAutoComplete(value, "Drop");
                print('Drop location: $value');
                // cabProvider.placeAutoComplete(value, "Drop");
              });
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: Color(0xff1937d7).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: Color(0xff1937d7),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Select on map",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff1937d7),
                          fontFamily: 'Poppins', // Set Poppins as the default font

                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade300,
          ),
          if (cabProvider.suggetions.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: cabProvider.suggetions.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    print("pickup===$isPickup");
                    if (isPickup) {
                      pickupController.text = cabProvider.pickupLocation ?? "";
                      cabProvider.getPickupLocation(cabProvider.suggetions[index].placePrediction?.text?.text ?? "",
                          cabProvider.suggetions[index].placePrediction?.placeId ?? "", "BookNow");
                      setState(() {});
                    } else {
                      cabProvider.getDropLocation(cabProvider.suggetions[index].placePrediction?.text?.text ?? "",
                          cabProvider.suggetions[index].placePrediction?.placeId ?? "", "BookNow");
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey.shade800,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, // Show ellipsis if text exceeds the limit
                                cabProvider.suggetions[index].placePrediction?.text?.text ?? "dehradun",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade800,
                                  fontFamily: 'Poppins', // Set Poppins as the default font

                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectVehicle()));
                },
                child: Customtbutton(
                  text: "Continue",
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
