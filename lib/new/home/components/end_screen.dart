import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeEndScreen extends StatelessWidget {
  const HomeEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(24),
      //  height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "India's most",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.grey.shade500
            ),
          ),
          Row(

            children: [
              Text(
                "trustable app",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey.shade500
                ),
              ),
              SvgPicture.asset(
                "assets/icons/heart.svg",
                width: 20, // Adjust the width as needed
                height: 40, // Adjust the height as needed
              ),
            ],
          ),

          SizedBox(height: 24,),
          Divider(
            thickness: 2,
          ),

          SizedBox(height: 16,),
          Text(
            'Grocery & Food Delivery Boy 😋',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade500
            ),
          ),

          SizedBox(height: 24,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/last_home.png",
                height: 320,
                width: 240,
              ),
            ],
          ),

          SizedBox(height: 10,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       'Something went wrong',
          //       style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.black87
          //       ),
          //     ),
          //   ],
          // ),
          //
          // SizedBox(height: 10,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       'Please try again later.',
          //       style: TextStyle(
          //           fontSize: 12,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.black54
          //       ),
          //     ),
          //   ],
          // ),
          //
          // SizedBox(height: 20,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       'Try again',
          //       style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w500,
          //           color: Colors.green.shade700
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}