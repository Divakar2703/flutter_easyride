import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/view/home/home_view.dart';
import 'package:flutter_easy_ride/view/home/service/home_service.dart';
import 'package:flutter_easy_ride/view/notification/ui/notification_screen.dart';
import 'package:flutter_easy_ride/view/payments/wallet_screen.dart';
import 'package:flutter_easy_ride/view/profile/profile_screen.dart';

class BottomBarProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List pages = [HomeScreen(), WalletScreen(), NotificationScreen(), ProfileScreen()];

  final homeService = HomeService();

  changePage(int index) {
    if (index != selectedIndex) selectedIndex = index;
    notifyListeners();
  }

  authentication() {
    try {
      final resp = homeService.authentication();
    } catch (e) {}
  }
}
