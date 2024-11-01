import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';

import '../../service/api_helper.dart';

class PreebookingProvider with ChangeNotifier {
  var data1;
  Future<void> confirmpreebook() async {
    Map<String, dynamic> requestbody = {
      "pickup_lat": 18.4848933,
      "pickup_long": 73.9369676,
      "drop_lat": 27.210052664323,
      "drop_long": 83.891678676009,
      "added_by_web": "asatvindia.in",
      "pickup_address":
      "Dr. Shyamu medical store, Turkaha, Uttar Pradesh 274801, India",
      "drop_address": "6V6V+J48, Turkaha, Uttar Pradesh 274801, India",
      "booking_type": "pre_booking",
      "user_id": 6,
      "selectedtime": "11.40",
      "selectdate": "26/10/2024"
    };

    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.confirmbooking, requestbody);
      print('${response.statusCode}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data1 = data;
        print(data1);

        print('${response.body}');
      } else {
        print('Please check your code');
      }
    } catch (Error) {
      throw 'Data is not found';
    }
  }
}
