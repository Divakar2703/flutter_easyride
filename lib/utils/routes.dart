import 'package:flutter/material.dart';
import '../Pre_Booking/screens/select_pickup_time.dart';
import '../view/home/home_view.dart';

class Routes {
  static const String homeview = '/homeview';
  static const String selectpickuptimegin = '/helectPickupTime';
  static const String profile = 'profile';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeview:
        return MaterialPageRoute(builder: (_) => HomeView());
      case selectpickuptimegin:
        return MaterialPageRoute(builder: (_) => SelectPickupTime());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route difined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
