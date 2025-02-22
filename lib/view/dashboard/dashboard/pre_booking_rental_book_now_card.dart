import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/screens/book_now_screen.dart';
import 'package:flutter_easy_ride/Pre_Booking/screens/pre_booking_screen.dart';

import '../../../rental/rental_hourly_and_recurring_view.dart';

class PreBookingRentalBookNowCard extends StatelessWidget {
  const PreBookingRentalBookNowCard({super.key});

  void navigate(BuildContext context, String destination) {
    if(destination=="Book Now"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookNowScreen()));

    }
    else if(destination=="Pre-Booking"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PreBookingScreen()));

    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RentalHourlyAndRecurringView()), // Replace with your actual destination widget.
      );
    }

  }

  Widget _buildCard(String title, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () => navigate(context, title),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 12, top: 8, bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            // color: Colors.white,
    gradient: LinearGradient(
    colors: [
    Colors.blue.shade300,
    Colors.blue.shade600
    ],)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCard("Book Now", Icons.directions_car_filled, context),
          _buildCard("Pre-Booking", Icons.access_time_rounded, context),
          _buildCard("Rental", Icons.directions_car, context),
        ],
      ),
    );
  }
}
