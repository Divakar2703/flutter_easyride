import 'package:flutter/material.dart';

import '../nav_Bar.dart';
import 'Components/select_Pickup.dart';
import 'Components/select_vehicle.dart';

final Color kDarkBlueColor = const Color(0xFFffb917);
class HomePagerrr extends StatefulWidget {
  const HomePagerrr({super.key});

  @override
  State<HomePagerrr> createState() => _HomePageState();
}

class _HomePageState extends State<HomePagerrr> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
    drawer: NavBar(), // Providing the NavBar widget as the drawer
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/m.png',), // Replace "assets/background_image.jpg" with your actual image path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                child: Row(
                  children: [
                    Material(
                      shape: CircleBorder(),
                      elevation: 4, // Adjust elevation as needed
                      child: SizedBox(
                        width: 38.0, // Adjust width as needed
                        height: 38.0, // Adjust height as needed
                        child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                          },
                          splashRadius: 20,
                          iconSize: 22.0, // Adjust icon size as needed
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Material(
                          elevation: 6,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Column(
                            children: [
                              Container(
                                height: 42.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  // border: Border.all(
                                  //   color: Colors.grey,
                                  // ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Your current location',
                                          hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                                          prefixIcon: Icon(
                                            Icons.do_not_disturb_on_total_silence,
                                            color: Colors.green.shade700,
                                            size: 20,
                                          ), // Icon added here
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10), // Space between the label and the TextField

                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPickop()));

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 12),
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.access_time_filled,
                                              color: Colors.black54,size: 18,),
                                            SizedBox(width: 5,),
                                            Text(
                                              'Now',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 8,),

                                            Icon(Icons.arrow_drop_down,
                                              color: Colors.black54,size: 18,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )

                        ),
                      ),
                    ),
                  ],
                ),
              ),


              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              //  // height: 150,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.only(
              //       topRight: Radius.circular(16),
              //       topLeft: Radius.circular(16)
              //     ),
              //     color: Colors.white
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             'We are not available in your area yet',
              //             style: TextStyle(
              //               fontSize: 17,
              //               color: Colors.black87,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ],
              //       ),
              //
              //       Divider(
              //         thickness: 1,
              //       ),
              //
              //       Row(
              //         children: [
              //           Icon(Icons.do_not_disturb_on_total_silence,
              //             color: Colors.green.shade600,size: 20,),
              //           SizedBox(width: 20,),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 'Chittorgarh, Rajsthan',
              //                 style: TextStyle(
              //                   fontSize: 13,
              //                   color: Colors.grey.shade800,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               Text(
              //                 'India',
              //                 style: TextStyle(
              //                   fontSize: 13,
              //                   color: Colors.grey.shade600,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //
              //
              //       SizedBox(height: 10,),
              //       Text(
              //         'Please search another pickup location or select on with the help of map',
              //         style: TextStyle(
              //           fontSize: 15,
              //           color: Colors.black87,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //
              //       GestureDetector(
              //         onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPickop()));
              //
              //         },
              //         child: Container(
              //           margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              //           height: 40,
              //           width: double.infinity,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(40),
              //             color: kDarkBlueColor
              //           ),
              //           child:Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 "Select Pickup",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   color: Colors.black87,
              //                   fontSize: 13.0,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),


              Container(
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                // height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16)
                    ),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select Destination',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),

                    Divider(
                      thickness: 1,
                    ),

                    Container(
                    //  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      //height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 35.0,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Pickup location',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric
                                  (horizontal: 24.0,vertical: 12),
                                prefixIcon: Icon(Icons.do_not_disturb_on_total_silence,
                                  color: Colors.green.shade800,size: 18,
                                ), // Icon added here
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey.shade300,
                          ),
                          Container(
                            height: 35.0,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Drop location',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric
                                  (horizontal: 24.0,vertical: 12),
                                prefixIcon: Icon(Icons.do_not_disturb_on_total_silence,
                                  color: Colors.red.shade700,size: 18,
                                ), // Icon added here
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                          color: Colors.grey.shade800,size: 20,),
                        SizedBox(width: 5,),
                        Text(
                          'Kota Juction,RIDDHI SIDHHI NAGAR...',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),


                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                          color: Colors.grey.shade800,size: 20,),
                        SizedBox(width: 5,),
                        Text(
                          'Chittorgarh, Tilak nagar, 13A Road',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SelectVehicle()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kDarkBlueColor
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select Pickup",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}