import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home/home_Pagerrr.dart';

class LocationScreen extends StatefulWidget {


  final Color kDarkBlueColor = const Color(0xFFffb917);

  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/locationbg.png',), // Replace 'assets/background_image.jpg' with your image path
                fit: BoxFit.cover, // Adjust this according to your needs
              ),
            ),
          ),

          const SizedBox(
            height: 50,
          ),
          Text(
            'Hi, nice to meet you!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              'Request a ride get picked up by a nearby community driver',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: (){
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const HomePagerrr(),
        ),
      );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFffb917),
                  width: 2
                )
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Use current location',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFffb917),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 50,
          ),
          Text(
            'Select it manually',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              decorationColor: Colors.black87, // Color of the underline
              decorationThickness: 2.0, // Thickness of the underline
            ),
          ),

        ],
      ),
    );
  }
}
