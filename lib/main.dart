import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/book_easyride/provider/triphistry_provider.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/provider/dashboard_provider.dart';
import 'package:flutter_easy_ride/provider/map_provider.dart';
import 'package:flutter_easy_ride/rental/components/rentalbooking_provider.dart';
import 'package:flutter_easy_ride/rental/get_rental_vehical_provider.dart';
import 'package:flutter_easy_ride/rental/recurring/recurringbooking_provider.dart';
import 'package:flutter_easy_ride/splesh_Screen.dart';
import 'package:flutter_easy_ride/utils/converter_function.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/view/authentication/provider/auth_provider.dart';
import 'package:flutter_easy_ride/view/authentication/signup.dart';
import 'package:flutter_easy_ride/view/dashboard/dashboard_map.dart';
import 'package:flutter_easy_ride/view/notification/notification_service.dart';
import 'package:provider/provider.dart';
import 'Book_Now/provider/drive_looking_provider.dart';
import 'Book_Now/screens/book_now_screen.dart';
import 'Pre_Booking/provider/preebooking_provider.dart';

import 'book_easyride/new_screen/confirm_booking.dart';
import 'check_api.dart';
import 'view/home/home_view.dart';
var navigatorKey=GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CabBookProvider()),
        ChangeNotifierProvider(create: (_)=>ApiProvider()),
        ChangeNotifierProvider(create: (_)=>MapProvider()),
        ChangeNotifierProvider(create: (_)=>ProgressBarState()),
        ChangeNotifierProvider(create: (_)=>TriphistryProvider()),
        ChangeNotifierProvider(create: (_)=>PreebookingProvider()),
        ChangeNotifierProvider(create: (_) => RentalbookingProvider()),
        ChangeNotifierProvider(create: (_) => RecurringBookingProvider()),
        ChangeNotifierProvider(create: (_) => GetRentalVehicleProvider()),
        ChangeNotifierProvider(create:(_) => DashboardProvider()),
        ChangeNotifierProvider(create:(_) => AuthProvider()),
      ],
      child:
      //MyApp()
      DevicePreview(
        builder: (BuildContext context) {
            return MyApp();},)
  ));

}
Future<void> requestNotificationPermission() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted notification permission');
  } else {
    print('User declined notification permission');
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase even in background for data access if needed
  await Firebase.initializeApp();
  print("Handling background message: ${message.messageId}");

  // Extract notification data
  String title = message.data["title"] ?? '';
  String body = message.data["body"] ?? '';
  String dataTitle = message.data["title"] ?? '';
  String dataBody = message.data["body"] ?? '';



}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _firebaseMessaging.getToken().then((token) {
      print("Firebase Token: $token");
      fToken=token??"";
    });
    Provider.of<ApiProvider>(context, listen: false)
        .fetchAuth()
        .then((_) {
      // After fetching auth, call the next method
      Provider.of<ApiProvider>(context, listen: false).fetchTheme();
    })
        .catchError((error) {
      // Handle errors if needed
      print("Error: $error");
    });  }
Future<void> getData() async {
    userID=await LocalStorage.getUserID();
    setState(() {
    });
}
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor:ConverterFunction.parseColor(value.themeConfigg!.lightTheme.primaryColor) ,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:userID==""?ChangeNotifierProvider(
              create: (BuildContext context) =>AuthProvider(),
              child: SignUpScreen()
          ):

          ChangeNotifierProvider(
              create: (BuildContext context)=>DashboardProvider(),
              child:
             //HomeView()
              DashboardMap()
          )
          //BookRideScreen(),
        );
      },
    );
  }
}


