import 'package:flutter/material.dart';

class PreBookingRentalBookNowCard extends StatelessWidget {
  const PreBookingRentalBookNowCard({super.key});

  void navigate(BuildContext context, String destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Text(destination)), // Replace with your actual destination widget.
    );
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
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
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
