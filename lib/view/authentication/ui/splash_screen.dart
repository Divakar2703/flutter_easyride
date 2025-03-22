import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/view/authentication/ui/login_screen.dart';
import 'package:flutter_easy_ride/view/home/ui/bottom_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 3),
        () => userID == ""
            ? Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false)
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomBarScreen(userID: userID) /*DashboardMap()*/),
                (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImage.appLogo, width: 125, height: 112),
      ),
    );
  }
}
