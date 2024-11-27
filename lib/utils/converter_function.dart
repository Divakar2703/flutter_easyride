import 'dart:ui';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class ConverterFunction{
  static Color parseColor(String hexColor) {
    // Ensure the color string has a valid length of 6 or 8 (e.g., FFD700 or 0xFF00FF00)
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add full opacity if only 6 characters
    }
    return Color(int.parse("0x$hexColor"));
  }
} 