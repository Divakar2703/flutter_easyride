import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/book_easyride/model/histrydetails.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import '../../service/api_helper.dart';
import '../model/triphistry.dart';

class TriphistryProvider with ChangeNotifier {
  List<ListElement> _historyList = [];
  List<ListElement> get historyList => _historyList; //trip histry
  TripHistryModel? triphistory;
  TripHistryModel? get triphistrylist => triphistory; // trip histry details

  Future<void> GetHistory() async {
    Map<String, dynamic> requestbody = {
      "user_id": 6,
      "pageno": 1,
      "daterange": ""
    };
    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.triphistry, requestbody);
      Map<String, dynamic> json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        History history = History.fromJson(json);
        _historyList = history.list;
        notifyListeners();
      } else {
        print('Failed to  load data');
      }
    } catch (Error) {
      print('not featch data please do correct code');
    }
  }

  //  triphistry details

  Future<void> triphistryDetails() async {
    Map<String, dynamic> requestbody = {"booking_id": "Book-00852362"};
    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.triphistrydetails, requestbody);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        triphistory = TripHistryModel.fromJson(jsonData);
        notifyListeners();
      } else {
        print('Error please you code');
      }
    } catch (Error) {
      throw 'Histry not found';
    }
  }
}
