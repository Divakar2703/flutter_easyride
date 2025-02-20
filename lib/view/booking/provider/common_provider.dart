import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  int selectedIndex = 0;

  changeBooking(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
