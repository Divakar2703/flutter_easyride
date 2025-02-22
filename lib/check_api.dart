import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookRideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40), // Status Bar Height
                Text(
                  "Book Ride",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'CustomFont',
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChoiceChip(
                      label: Text("Economy"),
                      selected: true,
                      onSelected: (value) {},
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    ChoiceChip(
                      label: Text("Premium"),
                      selected: false,
                      onSelected: (value) {},
                      selectedColor: AppColors.secondary,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Map Section
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.7749, -122.4194), // Example coordinates
                    zoom: 14,
                  ),
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                ),
                // Center Marker
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/car_marker.svg',
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
          ),
          // Info and Buttons Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RideOption(
                      icon: 'assets/icons/economy.svg',
                      label: "Economy",
                      price: "\$22.2",
                      selected: true,
                    ),
                    RideOption(
                      icon: 'assets/icons/suv.svg',
                      label: "SUV",
                      price: "\$25.3",
                      selected: false,
                    ),
                    RideOption(
                      icon: 'assets/icons/premium.svg',
                      label: "Premium",
                      price: "\$30.0",
                      selected: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Ride Option Widget
class RideOption extends StatelessWidget {
  final String icon;
  final String label;
  final String price;
  final bool selected;

  const RideOption({
    required this.icon,
    required this.label,
    required this.price,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor:
          selected ? AppColors.primary : AppColors.background,
          radius: 30,
          child: SvgPicture.asset(
            icon,
            height: 30,
            width: 30,
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'CustomFont',
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 2),
        Text(
          price,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'CustomFont',
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// Color Palette
class AppColors {
  static const background = Color(0xFFF5F5F5);
  static const primary = Color(0xFF58C4C6);
  static const secondary = Color(0xFFFAA21B);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF7D7D7D);
}
