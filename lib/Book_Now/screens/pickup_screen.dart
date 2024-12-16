import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/screens/select_vehicle.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
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
  @override
  void initState() {
    super.initState();

    Provider.of<CabBookProvider>(context, listen: false).getCurrentLocation();
  }
  @override
  void dispose() {
    pickupController.dispose();
    dropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cabProvider = Provider.of<CabBookProvider>(context);
    if (cabProvider.pickupLocation == null) {
      pickupController.text = cabProvider.pickupLocation!;
    }
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Color(0xff1937d7),
        title: Text(
          'Pickup',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins', // Set Poppins as the default font
              fontSize: 17,
              color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 21,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body:Column(
        children: [
          // Container(
          //  // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //   decoration: BoxDecoration(
          //     color:  Color(0xff1937d7),
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(20),
          //       bottomRight: Radius.circular(20)
          //     ),
          //     border: Border.all(
          //       color: Colors.white54,
          //       width: 1.5,
          //     ),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //
          //       Container(
          //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           border: Border.all(
          //             color: Colors.grey.shade300,
          //             width: 1.5,
          //           ),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             TextFormField(
          //               controller: _pickupController,
          //               style: const TextStyle(color: Colors.black),  // Text color inside the field
          //               decoration: InputDecoration(
          //                 hintText: 'Pickup location',
          //                 hintStyle: const TextStyle(color: Colors.grey),  // Hint text color
          //                 border: InputBorder.none,  // No border on the form field itself
          //                 contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          //                 prefixIcon: const Icon(
          //                   Icons.location_on_rounded,
          //                   color: Colors.green,
          //                   size: 22,
          //                 ),
          //               ),
          //               onChanged: (value) {
          //                 cabProvider.placeAutoComplete(value, "Pickup");
          //               },
          //               onTap: () {
          //                 _pickupController.clear();
          //               },
          //               validator: (value) {
          //                 if (value == null || value.isEmpty) {
          //                   return 'Please enter a pickup location';  // Add form validation here
          //                 }
          //                 return null;
          //               },
          //             ),                      // const Divider(),
          //             // Drop Location Input
          //             const Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 12),
          //               child: Icon(
          //                 Icons.more_vert,
          //                 color: Colors.white,
          //                 size: 24.0, // Adjust the size as needed
          //               ),
          //             ),
          //             TextField(
          //               controller: TextEditingController(
          //                 text: cabProvider.dropLocation
          //               ),
          //               style: TextStyle(color: Colors.white),
          //               decoration:  InputDecoration(
          //                 hintText: 'Drop location',
          //                 hintStyle: TextStyle(color: Colors.white),
          //                 border: OutlineInputBorder(  // White border for the TextField
          //                   borderRadius: BorderRadius.circular(10),
          //                   borderSide: BorderSide(color: Colors.white),
          //                 ),
          //                 enabledBorder: OutlineInputBorder( // White border when enabled
          //                   borderRadius: BorderRadius.circular(10),
          //                   borderSide: BorderSide(color: Colors.white),
          //                 ),
          //                 focusedBorder: OutlineInputBorder( // White border when focused
          //                   borderRadius: BorderRadius.circular(10),
          //                   borderSide: BorderSide(color: Colors.white),
          //                 ),                          contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          //                 prefixIcon: Icon(
          //                   Icons.location_on_rounded,
          //                   color: Colors.red,
          //                   size: 22,
          //                 ),
          //               ),
          //               onChanged: (value){
          //                 cabProvider.placeAutoComplete(value,"Drop");
          //               },
          //
          //               onTap: () async {
          //
          //                 // Navigate to map to select drop location
          //                 // Assuming you have a map screen to select a location
          //                 // final selectedLocation = await Navigator.push(
          //                 //   context,
          //                 //   MaterialPageRoute(
          //                 //     builder: (context) => SelectLocationOnMap(),
          //                 //   ),
          //                 // );
          //                 // if (selectedLocation != null) {
          //                 //   cabProvider.setDropLocation(selectedLocation);
          //                 // }
          //
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //
          //       // Container(
          //       //   child: TextField(
          //       //     decoration: InputDecoration(
          //       //       hintText: 'Pickup location',
          //       //       hintStyle: TextStyle(
          //       //         color: Colors.black54,
          //       //         fontSize: 15,
          //       //         fontFamily: 'Poppins',
          //       //         fontWeight: FontWeight.w400,
          //       //       ),
          //       //       border: InputBorder.none,
          //       //       contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          //       //       prefixIcon: Icon(
          //       //         Icons.location_on_rounded,
          //       //         color: Colors.green.shade800,
          //       //         size: 22,
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //       // Padding(
          //       //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //       //   child: Icon(
          //       //     Icons.more_vert,
          //       //     color: Colors.grey.shade500,
          //       //     size: 24.0, // Adjust the size as needed
          //       //   ),
          //       // ),
          //       // Container(
          //       //   child: TextField(
          //       //     decoration: InputDecoration(
          //       //       hintText: 'Drop location',
          //       //       hintStyle: TextStyle(
          //       //         color: Colors.black54,
          //       //         fontSize: 15,
          //       //         fontFamily: 'Poppins',
          //       //         fontWeight: FontWeight.w400,
          //       //       ),
          //       //       border: InputBorder.none,
          //       //       contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          //       //       prefixIcon: Icon(
          //       //         Icons.location_on_rounded,
          //       //         color: Colors.red.shade700,
          //       //         size: 22,
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          // PickupDropWidget(
          //   pickupController: pickupController,
          //   dropController: dropController,
          //   onChange: (value) {
          //     dropController.text=value;
          //   cabProvider.placeAutoComplete(value,"Drop");
          //   setState(() {
          //   });
          //  // LocationUtils.searchPlaces(value);
          // },
          // ),

          PickupDropWidget(
            onTap: (){
              pickupController.clear();
            },
            pickupController: pickupController,
            dropController: dropController,

            // onChange for Pickup
            onPickupChange: (value) {
              setState(() {
                pickupController.text = value; // Update pickup text
                cabProvider.placeAutoComplete(value,"Pickup");
                print('Pickup location: $value');
                // cabProvider.placeAutoComplete(value, "Pickup");
              });
            },

            // onChange for Drop
            onDropChange: (value) {
              setState(() {
                dropController.text = value; // Update drop text
                // Call your autoComplete function for Drop
                cabProvider.placeAutoComplete(value,"Drop");
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
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xff1937d7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade300
                    )
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,color: Color(0xff1937d7),),

                      SizedBox(width: 6,),
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

          if(cabProvider.suggetions.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: cabProvider.suggetions.length,
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: (){
                        cabProvider.getDropLocation(cabProvider.suggetions[index].placePrediction.text.text??"",cabProvider.suggetions[index].placePrediction.placeId??"","BookNow");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.watch_later_outlined,
                                  color: Colors.grey.shade800,size: 20,),
                                SizedBox(width: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.8,
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis, // Show ellipsis if text exceeds the limit
                                    cabProvider.suggetions[index].placePrediction.text.text??"dehradun",
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
                            Divider(color: Colors.grey.shade200,)
                          ],
                        ),
                      ),
                    ),
              ),
            ),
          // if(cabProvider.pickPlacePredictions.isNotEmpty)
          //   Container(
          //       height: 100,
          //       child: ListView.builder(
          //         itemCount: cabProvider.pickPlacePredictions.length,
          //         itemBuilder: (context, index) =>
          //             InkWell(
          //               onTap: (){
          //                 cabProvider.getDropLocation(cabProvider.pickPlacePredictions[index].description??"",cabProvider.pickPlacePredictions[index].placeId??"");
          //               },
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Row(
          //                   children: [
          //                     Icon(Icons.location_on_outlined,
          //                       color: Colors.grey.shade800,size: 20,),
          //                     SizedBox(width: 5,),
          //                     Text(
          //                       cabProvider.pickPlacePredictions[index].description??"dehradun",
          //                       style: TextStyle(
          //                         fontSize: 13,
          //                         color: Colors.grey.shade800,
          //                         fontFamily: 'Poppins', // Set Poppins as the default font
          //
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //       )),


          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectVehicle()));
            },
            child: Customtbutton(
              text: "Continue",
            )
            // Container(
            //   //  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            //   height: 44,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5),
            //     color: Color(0xff1937d7),
            //   ),
            //   child:const Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Select vehical",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontFamily: 'Poppins', // Set Poppins as the default font
            //           fontSize: 15.0,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}

