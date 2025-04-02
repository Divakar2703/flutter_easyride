import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:flutter_easy_ride/view/audio_call/web_rtc_service_provider.dart';
import 'package:flutter_easy_ride/view/authentication/provider/auth_provider.dart';
import 'package:flutter_easy_ride/view/authentication/ui/splash_screen.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/car_selection/provider/car_selection_provider.dart';
import 'package:flutter_easy_ride/view/driver_details/provider/driver_details_provider.dart';
import 'package:flutter_easy_ride/view/driver_details/ui/driver_detail_screen.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:flutter_easy_ride/view/home/provider/dashboard_provider.dart';
import 'package:flutter_easy_ride/view/payments/provider/payment_provider.dart';
import 'package:flutter_easy_ride/view/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

var navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  setUp();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookNowProvider()),
        ChangeNotifierProvider(create: (_) => CarSelectionProvider()),
        ChangeNotifierProvider(create: (_) => DriverDetailsProvider()),
        ChangeNotifierProvider(create: (_) => BottomBarProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => WebRTCProvider()),
      ],
      child: MyApp(),
    ),
  );
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
    super.initState();
    commonCall();
    _firebaseMessaging.getToken().then((token) => print(token ?? ""));
  }

  commonCall() async {
    await context.read<ApiProvider>().fetchAuth();
  }

  @override
  Widget build(BuildContext context) => Consumer<ApiProvider>(
        builder: (BuildContext context, value, Widget? child) => MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(scaffoldBackgroundColor: Colors.white
                // primaryColor: ConverterFunction.parseColor(value.themeConfigg?.lightTheme.primaryColor ?? "FFFFF"),
                // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                // useMaterial3: true,
                ),
            home:
                //DriverDetailScreen()
                SplashScreen()
            //BookRideScreen(),
            ),
      );
}
