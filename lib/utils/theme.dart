import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      primaryColorDark: AppColors.red,
      primaryColorLight: AppColors.white,
      dataTableTheme: DataTableThemeData(
        headingTextStyle:
            GoogleFonts.chakraPetch(color: AppColors.black, fontSize: 12),
        dividerThickness: 1,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => AppColors.black,
        ),
      ),
      cardColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.gold,
        elevation: 1,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
        shadowColor: AppColors.red,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.black),
        displayMedium: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black),
        displaySmall: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.normal, fontSize: 12, color: AppColors.red),
        titleLarge: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.black),
        titleMedium: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.black),
        titleSmall: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.grey.shade500),
        bodyLarge: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: AppColors.black),
        bodyMedium: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.normal,
            fontSize: 13,
            color: AppColors.black),
        bodySmall: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.black.withOpacity(.7)),
      ),
      iconTheme: IconThemeData(color: Colors.grey.shade400),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.gold,
      primaryColorDark: AppColors.white,
      primaryColorLight: AppColors.red,
      dataTableTheme: DataTableThemeData(
        headingTextStyle: GoogleFonts.chakraPetch(
          color: AppColors.red,
        ),
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => AppColors.white,
        ),
      ),
      toggleButtonsTheme: const ToggleButtonsThemeData(
          color: AppColors.white, selectedColor: AppColors.red),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.black),
        displayMedium: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black),
        displaySmall: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.normal, fontSize: 15, color: AppColors.red),
        titleLarge: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.white),
        titleMedium: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.white),
        titleSmall: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.grey.shade500),
        labelMedium: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.black),
        bodyLarge: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: AppColors.black),
        bodyMedium: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: AppColors.black),
        bodySmall: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.white),
      ),
      iconTheme: IconThemeData(color: Colors.grey.shade500),
    );
  }
}
