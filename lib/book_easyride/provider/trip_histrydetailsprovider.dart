import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/book_easyride/model/histrydetails.dart';

class TripHistrydetailsprovider with ChangeNotifier {
  List<HistoryDetails> _historyList = [];
  List<HistoryDetails> get historyList => _historyList;

  Future<void> fetchHistoryDetails() async {
    final url =
        Uri.parse("https://asatvindia.in/cab/Api/User/trip_history_details");
    final headers = {
      'username': 'cabadmin',
      'password': '060789c53dd8c490b0e4695ba678f1a0',
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);
        if (data['status'] == 'success') {
          _historyList = (data['data'] as List)
              .map((item) => HistoryDetails.fromJson(item))
              .toList();
          notifyListeners();
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
