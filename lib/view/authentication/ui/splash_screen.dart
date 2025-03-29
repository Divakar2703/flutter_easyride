import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/view/audio_call/web_rtc_service_provider.dart';
import 'package:flutter_easy_ride/view/authentication/ui/login_screen.dart';
import 'package:flutter_easy_ride/view/home/ui/bottom_bar_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WebRTCProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 3), () {
      if (userID == "") {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
      } else {
        context.read<WebRTCProvider>().initSocket(userID);
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => BottomBarScreen()), (route) => false);
      }
    });
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
