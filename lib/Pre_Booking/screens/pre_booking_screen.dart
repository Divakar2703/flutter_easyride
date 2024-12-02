import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/Pre_Booking/screens/select_pickup_time.dart';
import 'package:provider/provider.dart';
import '../../common_widget/custombutton.dart';
import '../../common_widget/pickup_drop_widget.dart';
import '../../internate/networkconnection.dart';
import '../../utils/routes.dart';
import '../../view/map/map_screen.dart';

class PreBookingScreen extends StatefulWidget {
  const PreBookingScreen({super.key});

  @override
  State<PreBookingScreen> createState() => _PreBookingScreenState();
}

class _PreBookingScreenState extends State<PreBookingScreen> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cabProvider = Provider.of<CabBookProvider>(context);
    if (cabProvider.pickupLocation != null ||
        cabProvider.dropLocation != null) {
      pickupController.text = cabProvider.pickupLocation!;
      dropController.text = cabProvider.dropLocation ?? "";
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
          ConnectivityChecker(),
          PickupDropWidget(
            pickupController: pickupController,
            dropController: dropController,
            onChange: (value) {
              dropController.text=value;
              cabProvider.placeAutoComplete(value, "Drop");
            },
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
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
                          fontFamily:
                              'Poppins', // Set Poppins as the default font
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
            Container(
                height: 100,
                child: ListView.builder(
                  itemCount: cabProvider.suggetions.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      cabProvider.getDropLocation(cabProvider.suggetions[index].placePrediction.text.text??"",cabProvider.suggetions[index].placePrediction.placeId??"","PreBooking");
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
                          SizedBox(
                            width: 5,
                          ),
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
                    ),
                  ),
                )),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPickupTime()));
             // Navigator.pushNamed(context, Routes.selectpickuptimegin);
            },
            child:
            Customtbutton(
              text: "Set Pickup time",

              )
            // Container(
            //   margin: EdgeInsets.only(left: 10, right: 10),
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5),
            //     color: Color(0xff1937d7),
            //   ),
            //   child: const Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Set Pickup time",
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
