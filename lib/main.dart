import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/provider/map_provider.dart';
import 'package:provider/provider.dart';
import 'Book_Now/provider/drive_looking_provider.dart';
import 'book_easyride/new_screen/bankselection.dart';
import 'book_easyride/new_screen/confirm_booking.dart';
import 'book_easyride/new_screen/time.dart';
import 'book_easyride/new_screen/triphistry_details.dart';
import 'book_easyride/provider/trip_histry_provider.dart';
import 'book_easyride/provider/trip_histrydetailsprovider.dart';
import 'provider/theme_provider.dart';
import 'view/home/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CabBookProvider()),
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => ProgressBarState()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TripHistrydetailsprovider()),
        ChangeNotifierProvider(create: (_) => TripHistoryProviders()),
      ],
      child: DevicePreview(
        builder: (BuildContext context) {
          return MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
        
       
     
     
    );
  }
}
