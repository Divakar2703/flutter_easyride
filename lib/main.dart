// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/book_easyride/provider/triphistry_provider.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:flutter_easy_ride/provider/map_provider.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/booking/provider/common_provider.dart';
import 'package:flutter_easy_ride/view/booking/provider/rental_provider.dart';
import 'package:flutter_easy_ride/view/car_selection/provider/car_selection_provider.dart';
import 'package:flutter_easy_ride/view/driver_details/provider/driver_details_provider.dart';
import 'package:flutter_easy_ride/view/home/bottom_bar_screen.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:provider/provider.dart';

import 'Book_Now/provider/drive_looking_provider.dart';
import 'Pre_Booking/provider/preebooking_provider.dart';

var navigatorKey = GlobalKey<NavigatorState>();
void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  setUp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CabBookProvider()),
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => ProgressBarState()),
        ChangeNotifierProvider(create: (_) => TriphistryProvider()),
        ChangeNotifierProvider(create: (_) => PreebookingProvider()),
        ChangeNotifierProvider(create: (_) => BookNowProvider()),
        ChangeNotifierProvider(create: (_) => RentalProvider()),
        ChangeNotifierProvider(create: (_) => CommonProvider()),
        ChangeNotifierProvider(create: (_) => CarSelectionProvider()),
        ChangeNotifierProvider(create: (_) => DriverDetailsProvider()),
        ChangeNotifierProvider(create: (_) => BottomBarProvider())
      ],
      child:
          // DevicePreview(
          // builder: (BuildContext context) {
          MyApp(),
      //   },
      // ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false)
        .fetchAuth()
        .then((_) => Provider.of<ApiProvider>(context, listen: false).fetchTheme())
        .catchError((error) => print("Error: $error"));
  }

  @override
  Widget build(BuildContext context) => Consumer<ApiProvider>(
        builder: (BuildContext context, value, Widget? child) => MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors.white),
            scaffoldBackgroundColor: AppColors.white,
            //   // primaryColor: ConverterFunction.parseColor(value.themeConfigg?.lightTheme.primaryColor ?? "FFD700"),
            //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            //   // useMaterial3: true,
          ),
          home: BottomBarScreen(),
        ),
      );
}
