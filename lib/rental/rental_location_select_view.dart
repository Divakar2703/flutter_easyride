import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/new/rental/select_recurring_rental_view.dart';
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

  TextEditingController _pickupController=TextEditingController();
  @override
  void initState() {
    super.initState();

    Provider.of<CabBookProvider>(context, listen: false).getCurrentLocation();
  }
  @override
  void dispose() {
    _pickupController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final cabProvider = Provider.of<CabBookProvider>(context);
    if (cabProvider.pickupLocation != null) {
      _pickupController.text = cabProvider.pickupLocation!;
    }
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Color(0xff1937d7),
        title: Text('Select Location',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
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
      body: Container(
        padding: EdgeInsets.all(16),
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
                  TextFormField(
                    controller: _pickupController,
                    style: const TextStyle(color: Colors.black),  // Text color inside the field
                    decoration: InputDecoration(
                      hintText: 'Enter pickup location',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.location_on_rounded,
                          color:Color(0xff1937d7),
                        ),
                      ),
                      // suffixIcon: const Padding(
                      //   padding: EdgeInsets.all(11.0),
                      //   child: Icon(
                      //     Icons.mic,
                      //     color: Colors.black54,
                      //     size: 22,
                      //   ),
                      // ),
                    ),
                    onChanged: (value) {
                      cabProvider.placeAutoComplete(value, "Pickup");
                    },
                    onTap: () {
                      _pickupController.clear();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a pickup location';  // Add form validation here
                      }
                      return null;
                    },
                  ),                      // const Divider(),
                  // Drop Location Input
                ],
              ),
            ),



            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
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
                        border: Border.all(
                            color: Colors.grey.shade300
                        )
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,color: Colors.black54,),

                        SizedBox(width: 6,),
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

            if(cabProvider.placePredictions.isNotEmpty)
              Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: cabProvider.placePredictions.length,
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: (){
                            cabProvider.getDropLocation(cabProvider.placePredictions[index].description??"");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                  color: Colors.grey.shade800,size: 20,),
                                SizedBox(width: 5,),
                                Text(
                                  cabProvider.placePredictions[index].description??"dehradun",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade800,
                                    fontFamily: 'Poppins', // Set Poppins as the default font

                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  )),
            if(cabProvider.pickPlacePredictions.isNotEmpty)
              Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: cabProvider.pickPlacePredictions.length,
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: (){
                            cabProvider.getDropLocation(cabProvider.pickPlacePredictions[index].description??"");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                  color: Colors.grey.shade800,size: 20,),
                                SizedBox(width: 5,),
                                Text(
                                  cabProvider.pickPlacePredictions[index].description??"dehradun",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade800,
                                    fontFamily: 'Poppins', // Set Poppins as the default font

                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  )),

            Spacer(),
            GestureDetector(
              onTap: (){
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
                child:Row(
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
