
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/theme_config.dart';
import 'package:flutter_easy_ride/service/api_helper.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart'as http;
import 'package:permission_handler/permission_handler.dart';

import '../utils/eve.dart';
import '../utils/local_storage.dart';

class ApiProvider with ChangeNotifier{
  ThemeConfig? themeConfig;
  ThemeConfig? get themeConfigg => themeConfig;


  Future<void> getCurrentLocation() async {
    print("hi");
    PermissionStatus permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      ALatitude = position.latitude;
      ALongitude = position.longitude;
      address =
      '${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
      print("lat==$ALatitude\nlong=$ALongitude");

      notifyListeners();
    }
  }

  Future<void> fetchAuth() async {
    final String url = ApiHelper.authApi;

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsondata=jsonDecode(response.body);
        List<dynamic> apiAuth=jsondata["api_auth"];
        var username= apiAuth[0]["username"];
        var password=apiAuth[0]["password"];
        await LocalStorage.saveUsername(username);
        await LocalStorage.savePassword(password);

      } else {
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
  }
  Future<void> fetchTheme() async {
    final String url = ApiHelper.getTheme;
    print("url===$url");


    try {
      final response = await NetworkUtility.sendGetRequest(url,);
      print('Response theme body: ${response.body}');

      if (response.statusCode == 200) {
        print('Response theme code: ${response.statusCode}');

      //  var data=jsonDecode(response.body);
        final Map<String, dynamic> data = json.decode(response.body);

         themeConfig=ThemeConfig.fromJson(data);
        print("themeconfig===${themeConfig}");
        notifyListeners();

      } else {
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
  }


}