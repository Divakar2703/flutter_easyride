import 'package:flutter/material.dart';

import 'image_slider.dart';

class NewConfirmBooking extends StatefulWidget {
  const NewConfirmBooking({super.key});

  @override
  State<NewConfirmBooking> createState() => _NewConfirmBookingState();
}

class _NewConfirmBookingState extends State<NewConfirmBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Stack(
          children: [
            PreeVehicle(),
            
            // Positioned(
            //   child: Center(
            //     child: Container(
            //       decoration:
            //           BoxDecoration(borderRadius: BorderRadius.circular(20),
            //           color: Colors.red
                      
                      
            //           ),
            //       width: 330,
            //       height: 300,
            //     ),
            //   ),
            // ),
            // Positioned(
            //   left: 10,
            //   right: 10,
            //   top: 235,
            //   child: Center(
            //     child: Container(
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.pink),
            //       width: 390,
            //       height: 240,
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: 200,
            //   child: Center(
            //     child: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.green,
            //           borderRadius: BorderRadius.circular(20)),
            //       width: 400,
            //       height: 200,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}


