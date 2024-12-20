import 'dart:ui';

class ConverterFunction{
  static Color parseColor(String hexColor) {
    // Ensure the color string has a valid length of 6 or 8 (e.g., FFD700 or 0xFF00FF00)
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add full opacity if only 6 characters
    }
    return Color(int.parse("0x$hexColor"));
  }
} 