import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/main.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/view/authentication/services/auth_service.dart';
import 'package:flutter_easy_ride/view/authentication/ui/login_screen.dart';
import 'package:flutter_easy_ride/view/home/ui/bottom_bar_screen.dart';

class AuthProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  final authService = AuthService();
  String? _mobileNumber;
  String? _otp;
  String? get mobileNumber => _mobileNumber;
  String? get otp => _otp;
  bool loading = false;

  /// User Registration
  Future<void> registerCabUser() async {
    loading = true;
    try {
      final resp = await authService.registerCabUser(
          email: emailController.text,
          name: nameController.text,
          phone: phoneController.text,
          fToken: fToken,
          referralId: referralController.text);

      if (resp == 200) {
        loading = false;
        Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => LoginScreen()));
        notifyListeners();
      } else {
        loading = false;
      }
    } catch (e) {
      loading = false;
    }
  }

  /// Set Mobile Number
  void setMobileNumber(String mobileNumber) {
    _mobileNumber = mobileNumber;
    notifyListeners();
  }

  /// Send Otp Api
  Future<bool> sendOtp(String mobileNumber) async {
    try {
      final resp = await authService.sendOtp(phone: mobileNumber);
      if (resp == 200) {
        _mobileNumber = mobileNumber;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Verify Otp Api
  Future<void> verifyOtp(String otp) async {
    try {
      final resp = await authService.verifyOtp(phone: mobileNumber, otp: otp);

      if (resp != null && resp.status == "success") {
        _otp = otp;
        userID = resp.data?.userId ?? "";
        await LocalStorage.saveUserID(resp.data?.userId ?? "");
        await LocalStorage.saveId(int.parse(resp.data?.id ?? "0"));
        Navigator.pushAndRemoveUntil(
          navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => BottomBarScreen()),
          (route) => false,
        );
        notifyListeners();
      }
    } catch (e) {}
  }
}
