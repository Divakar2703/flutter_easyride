import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CabCard extends StatelessWidget {
  final String? cabName;
  final String? cabImageUrl;

  CabCard({ this.cabName,  this.cabImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          Card(
            color: Colors.white.withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 3.0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10.0),

              ),
              child: Image.asset(
                "$cabImageUrl",
                width: 60,
                fit: BoxFit.contain,
                height: 50,
              ),
            ),
          ),
          Text(
            "$cabName",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
