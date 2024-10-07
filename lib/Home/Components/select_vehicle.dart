import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Home/Components/promocode.dart';
import 'car_select_contenor.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

class SelectVehicle extends StatefulWidget {
  const SelectVehicle({super.key});

  @override
  State<SelectVehicle> createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/m.png',), // Replace "assets/background_image.jpg" with your actual image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
      Spacer(),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    CarSelectContainer(),

                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        openPromocodeBottomSheet(context);
                      },
                      child: Container(
                        //  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                        height: 44,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kDarkBlueColor
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Confirm",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontSize: 18.0,
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
            )
          ],
        ),
      ),
    );
  }
}
