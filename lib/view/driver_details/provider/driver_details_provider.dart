import 'package:flutter/material.dart';

class DriverDetailsProvider with ChangeNotifier {
  bool isConfirmed = false;

  confirmRide() {
    isConfirmed = !isConfirmed;
    notifyListeners();
  }
}
