
import 'package:flutter/widgets.dart';
class ProgressBarState with ChangeNotifier {
  int _currentStep = 0;

  int get currentStep => _currentStep;


  void nextStep() {
    if (_currentStep < 4) {
      _currentStep++;
      notifyListeners();
    }
  }

  void resetSteps() {
    _currentStep = 0;
    notifyListeners();
  }
}