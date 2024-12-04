  import 'package:flutter/material.dart';

  class PendingBookingCard extends StatefulWidget {
    const PendingBookingCard({super.key});

    @override
    State<PendingBookingCard> createState() => _PendingBookingCardState();
  }

  class _PendingBookingCardState extends State<PendingBookingCard> {
    @override
    Widget build(BuildContext context) {
      return const Row(
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
                'Booking ID: 12345',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Pending since 10:00 AM',
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
