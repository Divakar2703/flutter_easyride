
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/main.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/view/authentication/login.dart';
import 'package:flutter_easy_ride/view/authentication/verify.dart';
import 'package:flutter_easy_ride/view/dashboard/dashboard_map.dart';

import '../../../model/login_response.dart';
import '../../../service/api_helper.dart';
import '../../../service/network_utility.dart';



class AuthProvider with ChangeNotifier{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  String? _mobileNumber;
  String? _otp;
  LoginResponse ?loginResponse;
  String? get mobileNumber => _mobileNumber;
  LoginResponse? get userData=> loginResponse;
  String? get otp => _otp;
  bool loading=false;
  Future<void> registerCabUser() async  {
    loading=true;
    final String url = ApiHelper.registerUser;
    var params={
      "email": emailController.text,
      "name": nameController.text,
      "phone": phoneController.text,
      "type": "cab",
      "f_token_app": fToken,
      "referId": referralController.text
    };
    print("params==${params}");

    try {
      final response = await NetworkUtility.sendPostRequest(url,params);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        loading=false;
        Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>LoginScreen()));
        notifyListeners();
      }
      else
      {
        loading=false;

        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      loading=false;
      print('Error sending POST request: $e');
    }
  }


  // Set mobile number
  void setMobileNumber(String mobileNumber) {
    _mobileNumber = mobileNumber;
    notifyListeners();
  }

  // Send OTP API call
  Future<bool> sendOtp(String mobileNumber) async {
     String apiUrl = ApiHelper.sendOtp;
     var params={
       "phone": mobileNumber,
     };
     print("params==${params}");
     final response = await NetworkUtility.sendPostRequest(apiUrl,params);
     print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      _mobileNumber = mobileNumber;
     // Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>VerifyScreen()));

      notifyListeners();
      return true;
    }
    return false;
  }

  // Verify OTP API call
  Future<bool> verifyOtp(String otp) async {
     String apiUrl = ApiHelper.verifyOtp;
     var params={
       "phone": mobileNumber,
       "otp":otp
     };
     final response = await NetworkUtility.sendPostRequest(apiUrl,params);

    if (response.statusCode == 200) {

      _otp = otp;
      var jsondata=jsonDecode(response.body);
      if(jsondata["status"]=="success"){
         loginResponse = LoginResponse.fromJson(jsondata);
        userID=loginResponse!.loginUserId;
        await LocalStorage.saveUserID(loginResponse!.loginUserId);

        Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>DashboardMap()));
        notifyListeners();
        return true;
      }
      else{
        return false;
      }

    }
    return false;
  }

}