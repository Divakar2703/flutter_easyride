import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/book_easyride/model/histrydetails.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import '../../service/api_helper.dart';
import '../model/triphistry.dart';

class TriphistryProvider with ChangeNotifier {
  TripHistryModel? tripHistryModel;
  TripHistryModel? get tripHistryModels => tripHistryModel;

  List<TripHistory> tripHistory=[];
  List<TripHistory> get tripHistorys => tripHistory;

  var histry1;
  Future<void> gethistryDetails() async {
    // trip histry details
    Map<String, dynamic> requestBody = {"booking_id": "Book-00852362"};

    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.triphistrydetails, requestBody);

      print('${'response.statusCode'}');

      Map<String, dynamic> jsondata = jsonDecode(response.body);

      if (response.statusCode == 200) {
        TripHistryModel response = TripHistryModel.fromJson(jsondata);
        print(response);

        print('Your data is a successfull featch from api');
      }
    } catch (Error) {
      throw 'Error please check your code';
    }
  }

  Future<void> gethistry() async {
    Map<String, dynamic> requestBody = {
      "user_id": 6,
      "pageno": 1,
      "daterange": "2024/05/04 - 2024/05/06"
    };

    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.triphistry, requestBody);
      Map<String, dynamic> histrydata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        TripHistory tripHistorys = TripHistory.fromJson(histrydata);
        print('${tripHistorys}');
      } else {
        print('please check you it is not correct ');
      }
    } catch (Error) {
      throw 'your data is not correct';
    }
  }



}
