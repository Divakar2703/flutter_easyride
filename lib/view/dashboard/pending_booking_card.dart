import 'package:flutter/material.dart';

class PendingBookingCard extends StatefulWidget {
  String bookingID;
  String entryTime;
   PendingBookingCard({super.key,required this.bookingID,required this.entryTime});

  @override
  State<PendingBookingCard> createState() => _PendingBookingCardState();
}

class _PendingBookingCardState extends State<PendingBookingCard> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // CircleAvatar(
        //   radius: 28,
        //   backgroundImage:AssetImage('assets/images/map.png'),
        //
        // ),
        Container(
          width: 56, // Diameter of the circle
          height: 56, // Diameter of the circle
          decoration: BoxDecoration(
            color: Colors.blue, // Background color of the circle
            shape: BoxShape.circle, // Makes the container circular
          ),
          child: Icon(
            Icons.location_on, // Location icon
            color: Colors.white, // Icon color
            size: 28, // Icon size
          ),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Booking ID: ${widget.bookingID}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 13,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Pending since ${widget.entryTime}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 11,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ],
    );
  }
}