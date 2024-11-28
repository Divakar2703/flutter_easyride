import 'dart:convert';

class ThemeConfig {
  final ThemeDataConfig lightTheme;
  // final ThemeDataConfig darkTheme;
  // final BookingConfig bookNow;
  // final BookingConfig preBooking;
  // final BookingConfig rental;




  ThemeConfig({
    required this.lightTheme,
    // required this.darkTheme,
    // required this.bookNow,
    // required this.preBooking,
    // required this.rental,
  });


  factory ThemeConfig.fromJson(Map<String, dynamic> json) {
    return ThemeConfig(
      lightTheme: ThemeDataConfig.fromJson(json['light_theme'])
    //   darkTheme: json['dark_theme'] != null
    //       ? ThemeDataConfig.fromJson(json['dark_theme'])
    //       : ThemeDataConfig.empty(),
    //   bookNow: BookingConfig.fromJson(json['book_now']),
    //   preBooking: BookingConfig.fromJson(json['pre_booking']),
    //   rental: BookingConfig.fromJson(json['rental']),
    );
  }

}

class ThemeDataConfig {
  final String primaryColor;
  final String primaryColorDark;
  final String primaryColorLight;
  final String cardColor;
  // final DataTableThemeConfig dataTableTheme;
  // final AppBarThemeConfig appBarTheme;
  // final TextThemeConfig textTheme;
  // final IconThemeConfig iconTheme;
  //  final GradientConfig gradient;

  ThemeDataConfig({
    required this.primaryColor,
    required this.primaryColorDark,
    required this.primaryColorLight,
     required this.cardColor,
    // required this.dataTableTheme,
    // required this.appBarTheme,
    // required this.textTheme,
    // required this.iconTheme,
    //  required this.gradient,
  });

  factory ThemeDataConfig.fromJson(Map<String, dynamic> json) {
    return ThemeDataConfig(
      primaryColor: json['primaryColor']??"",
      primaryColorDark: json['primaryColorDark']??"",
      primaryColorLight: json['primaryColorLight']??"",
      cardColor: json['cardColor']??"",
      // dataTableTheme: DataTableThemeConfig.fromJson(json['dataTableTheme']),
      // appBarTheme: AppBarThemeConfig.fromJson(json['appBarTheme']),
      // textTheme: TextThemeConfig.fromJson(json['textTheme']),
      // iconTheme: IconThemeConfig.fromJson(json['iconTheme']),
      //  gradient: GradientConfig.fromJson(json['gradient']),
    );
  }

  factory ThemeDataConfig.empty() {
    return ThemeDataConfig(
      primaryColor: '',
      primaryColorDark: '',
      primaryColorLight: '',
      cardColor: '',
      // dataTableTheme: DataTableThemeConfig.empty(),
      // appBarTheme: AppBarThemeConfig.empty(),
      // textTheme: TextThemeConfig.empty(),
      // iconTheme: IconThemeConfig.empty(),
      //  gradient: GradientConfig.empty(),
    );
  }
}

class DataTableThemeConfig {
  final TextStyleConfig headingTextStyle;
  final String dividerThickness;
  final String headingRowColor;

  DataTableThemeConfig({
    required this.headingTextStyle,
    required this.dividerThickness,
    required this.headingRowColor,
  });

  factory DataTableThemeConfig.fromJson(Map<String, dynamic> json) {
    return DataTableThemeConfig(
      headingTextStyle: TextStyleConfig.fromJson(json['headingTextStyle']),
      dividerThickness: json['dividerThickness'],
      headingRowColor: json['headingRowColor'],
    );
  }

  factory DataTableThemeConfig.empty() {
    return DataTableThemeConfig(
      headingTextStyle: TextStyleConfig.empty(),
      dividerThickness: '',
      headingRowColor: '',
    );
  }
}

class AppBarThemeConfig {
  final String backgroundColor;
  final String elevation;
  final BorderRadiusConfig shape;
  final String shadowColor;

  AppBarThemeConfig({
    required this.backgroundColor,
    required this.elevation,
    required this.shape,
    required this.shadowColor,
  });

  factory AppBarThemeConfig.fromJson(Map<String, dynamic> json) {
    return AppBarThemeConfig(
      backgroundColor: json['backgroundColor'],
      elevation: json['elevation'],
      shape: BorderRadiusConfig.fromJson(json['shape']['borderRadius']),
      shadowColor: json['shadowColor'],
    );
  }

  factory AppBarThemeConfig.empty() {
    return AppBarThemeConfig(
      backgroundColor: '',
      elevation: '',
      shape: BorderRadiusConfig.empty(),
      shadowColor: '',
    );
  }
}

class BorderRadiusConfig {
  final String bottomLeft;
  final String bottomRight;

  BorderRadiusConfig({
    required this.bottomLeft,
    required this.bottomRight,
  });

  factory BorderRadiusConfig.fromJson(Map<String, dynamic> json) {
    return BorderRadiusConfig(
      bottomLeft: json['bottomLeft'],
      bottomRight: json['bottomRight'],
    );
  }

  factory BorderRadiusConfig.empty() {
    return BorderRadiusConfig(
      bottomLeft: '',
      bottomRight: '',
    );
  }
}

class TextThemeConfig {
  final TextStyleConfig displayLarge;
  final TextStyleConfig displayMedium;
  final TextStyleConfig displaySmall;
  final TextStyleConfig titleLarge;
  final TextStyleConfig titleMedium;
  final TextStyleConfig titleSmall;
  final TextStyleConfig bodyLarge;
  final TextStyleConfig bodyMedium;
  final TextStyleConfig bodySmall;

  TextThemeConfig({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
  });

  factory TextThemeConfig.fromJson(Map<String, dynamic> json) {
    return TextThemeConfig(
      displayLarge: TextStyleConfig.fromJson(json['displayLarge']),
      displayMedium: TextStyleConfig.fromJson(json['displayMedium']),
      displaySmall: TextStyleConfig.fromJson(json['displaySmall']),
      titleLarge: TextStyleConfig.fromJson(json['titleLarge']),
      titleMedium: TextStyleConfig.fromJson(json['titleMedium']),
      titleSmall: TextStyleConfig.fromJson(json['titleSmall']),
      bodyLarge: TextStyleConfig.fromJson(json['bodyLarge']),
      bodyMedium: TextStyleConfig.fromJson(json['bodyMedium']),
      bodySmall: TextStyleConfig.fromJson(json['bodySmall']),
    );
  }

  factory TextThemeConfig.empty() {
    return TextThemeConfig(
      displayLarge: TextStyleConfig.empty(),
      displayMedium: TextStyleConfig.empty(),
      displaySmall: TextStyleConfig.empty(),
      titleLarge: TextStyleConfig.empty(),
      titleMedium: TextStyleConfig.empty(),
      titleSmall: TextStyleConfig.empty(),
      bodyLarge: TextStyleConfig.empty(),
      bodyMedium: TextStyleConfig.empty(),
      bodySmall: TextStyleConfig.empty(),
    );
  }
}

class TextStyleConfig {
  final String fontFamily;
  final String fontWeight;
  final int fontSize;
  final String color;

  TextStyleConfig({
    required this.fontFamily,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
  });

  factory TextStyleConfig.fromJson(Map<String, dynamic> json) {
    return TextStyleConfig(
      fontFamily: json['fontFamily'],
      fontWeight: json['fontWeight'],
      fontSize: int.parse(json['fontSize'].toString()),
      color: json['color'],
    );
  }

  factory TextStyleConfig.empty() {
    return TextStyleConfig(
      fontFamily: '',
      fontWeight: '',
      fontSize: 0,
      color: '',
    );
  }
}

class IconThemeConfig {
  final String color;

  IconThemeConfig({required this.color});

  factory IconThemeConfig.fromJson(Map<String, dynamic> json) {
    return IconThemeConfig(color: json['color']);
  }

  factory IconThemeConfig.empty() {
    return IconThemeConfig(color: '');
  }
}

class GradientConfig {
  final String startColor;
  final String centerColor;
  final String endColor;

  GradientConfig({
    required this.startColor,
    required this.centerColor,
    required this.endColor,
  });

  factory GradientConfig.fromJson(Map<String, dynamic> json) {
    return GradientConfig(
      startColor: json['start_color'],
      centerColor: json['center_color'],
      endColor: json['end_color'],
    );
  }

  factory GradientConfig.empty() {
    return GradientConfig(
      startColor: '',
      centerColor: '',
      endColor: '',
    );
  }
}

class BookingConfig {
  // Define booking configuration fields as per requirement.

  BookingConfig();

  factory BookingConfig.fromJson(Map<String, dynamic> json) {
    return BookingConfig();
  }
}
