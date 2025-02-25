import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Book_Now/provider/cab_book_provider.dart';
import '../view/map/map_screen.dart';
import 'components/select_rental_packege_view.dart';

class RentalLocationSelectView extends StatefulWidget {
  const RentalLocationSelectView({super.key});

  @override
  State<RentalLocationSelectView> createState() => _RentalLocationSelectViewState();
}

class _RentalLocationSelectViewState extends State<RentalLocationSelectView> {
  final _selectedSegment = ValueNotifier('inventory'); // 'inventory' is selected initially

  TextEditingController _pickupController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<CabBookProvider>(context, listen: false).getCurrentLocation();
    _pickupController.addListener(() {
      final cabProvider = Provider.of<CabBookProvider>(context, listen: false);
      if (_pickupController.text != cabProvider.pickupLocation) {
        cabProvider.setPickupLocation(_pickupController.text);
      }
    });
  }

  @override
  void dispose() {
    _pickupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cabProvider = Provider.of<CabBookProvider>(context);
    // if (cabProvider.pickupLocation != null) {
    //   _pickupController.text = cabProvider.pickupLocation!;
    // }
    if (cabProvider.pickupLocation != null && _pickupController.text.isEmpty) {
      _pickupController.text = cabProvider.pickupLocation!;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextFormField(
                //   controller: _pickupController,
                //   style: const TextStyle(color: Colors.black),  // Text color inside the field
                //   decoration: InputDecoration(
                //     hintText: 'Enter pickup location',
                //     hintStyle: const TextStyle(
                //       color: Colors.black54,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w400,
                //       fontFamily: 'Poppins',
                //     ),
                //     border: InputBorder.none,
                //     contentPadding: const EdgeInsets.symmetric(
                //         horizontal: 32.0, vertical: 12),
                //     prefixIcon: const Padding(
                //       padding: EdgeInsets.all(12.0),
                //       child: Icon(
                //         Icons.location_on_rounded,
                //         color:Color(0xff1937d7),
                //       ),
                //     ),
                //
                //   ),
                //   onChanged: (value) {
                //     cabProvider.placeAutoComplete(value, "Pickup");
                //   },
                //   onTap: () {
                //     _pickupController.clear();
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a pickup location';  // Add form validation here
                //     }
                //     return null;
                //   },
                // ),                      // const Divider(),
                // Drop Location Input

                TextFormField(
                  controller: _pickupController,
                  style: const TextStyle(color: Colors.black), // Text color inside the field
                  decoration: InputDecoration(
                    hintText: 'Enter pickup location',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Color(0xff1937d7),
                      ),
                    ),
                  ),
                  onTap: () {
                    _pickupController.clear(); // Clear the text when tapped
                  },
                  onChanged: (value) {
                    cabProvider.placeAutoComplete(value, "Pickup"); // Call to fetch suggestions
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a pickup location'; // Form validation message
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
            },
            child: Row(
              children: [
                Container(
                  width: 160,
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Color(0xff1937d7).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Select on map",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
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
                    String selectedAddress =
                        cabProvider.suggetions[index].placePrediction?.text?.text ?? "Unknown Address";
                    _pickupController.text = selectedAddress; // Set selected address
                    cabProvider.getDropLocation(
                      selectedAddress,
                      cabProvider.suggetions[index].placePrediction?.placeId ?? "",
                      "Pickup",
                    );
                    FocusScope.of(context).unfocus(); // Hide the keyboard
                    cabProvider.suggetions.clear(); // Clear suggestion list
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey.shade800,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            cabProvider.suggetions[index].placePrediction?.text?.text ?? "Dehradun",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // if (cabProvider.suggetions.isNotEmpty)
          //   Container(
          //       height: 100,
          //       child: ListView.builder(
          //         itemCount: cabProvider.suggetions.length,
          //         itemBuilder: (context, index) => InkWell(
          //           onTap: () {
          //             cabProvider.getDropLocation(cabProvider.suggetions[index].placePrediction.text.text??"",cabProvider.suggetions[index].placePrediction.placeId??"","Rental");
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               children: [
          //                 Icon(
          //                   Icons.location_on_outlined,
          //                   color: Colors.grey.shade800,
          //                   size: 20,
          //                 ),
          //                 SizedBox(
          //                   width: 5,
          //                 ),
          //                 Container(
          //                   width: MediaQuery.of(context).size.width*0.8,
          //                   child: Text(
          //                     maxLines: 2,
          //                     overflow: TextOverflow.ellipsis, // Show ellipsis if text exceeds the limit
          //                     cabProvider.suggetions[index].placePrediction.text.text??"dehradun",
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       color: Colors.grey.shade800,
          //                       fontFamily: 'Poppins', // Set Poppins as the default font
          //
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       )),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute());
            },
            child: Container(
              //  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              height: 44,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff1937d7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select rental packege",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins', // Set Poppins as the default font
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
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
      pageBuilder: (context, animation, secondaryAnimation) => SelectRentalPackegeView(),
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
