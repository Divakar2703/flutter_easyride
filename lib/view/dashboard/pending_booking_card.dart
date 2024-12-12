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
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage('assets/images/map.png'),
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