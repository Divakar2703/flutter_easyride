import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/book_easyride/model/histrydetails.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import '../../service/api_helper.dart';
import '../model/triphistry.dart';

class TriphistryProvider with ChangeNotifier {
  List<TripHistryModel> triphistrys = []; // trip histry details
  List<TripHistryModel> get triphis => triphistrys;
  var TripHistryModel1;

  TripHistryModel? triphistory;
  TripHistryModel? get triphistrylist => triphistory;

  List<ListElement> _historyList = [];
  List<ListElement> get historyList => _historyList; //trip histry

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

  Future<void> gethistryDetails() async {
    Map<String, dynamic> requestBody = {"booking_id": "Book-00852362"};

    try {
      final response = await NetworkUtility.sendPostRequest(
        ApiHelper.triphistrydetails,
        requestBody,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        if (json["data"] != null && json["data"] is List) {
          List<dynamic> tripList = json["data"];
          print(tripList);

          triphistrys = tripList
              .map((tripData) => TripHistryModel.fromJson(tripData))
              .toList();
        } else {
          triphistrys = [];
        }
        notifyListeners();
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error loading trip history details: $e');
    }
  }

  Future<void> getallhistry() async {
    Map<String, dynamic> requestbody = {"booking_id": "Book-00852362"};

    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.triphistrydetails, requestbody);

      if (response.statusCode == 200) {
        var triphistrylist = jsonDecode(response.body);
        var triphistrylist1 = triphistrylist;

        print(triphistrylist1);
      } else {
        print('Data is not featch please check your code');
      }
    } catch (Error) {}
  }
}






