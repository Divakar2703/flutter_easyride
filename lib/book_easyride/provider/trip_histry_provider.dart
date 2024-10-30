import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/triphistry.dart';
import 'package:http/http.dart' as http;

class TripHistoryProviders with ChangeNotifier {
  List<TripHistory>? _tripHistoryList = [];
  List<TripHistory>? get tripHistoryList => _tripHistoryList;

  Future<void> fetchTripHistory(
      int userId, int pageNo, String dateRange) async {
    final url = Uri.parse('https://asatvindia.in/cab/Api/User/trip_history');
    final headers = {
      'Authorization': 'Basic ' +
          base64Encode(
              utf8.encode('cabadmin:060789c53dd8c490b0e4695ba678f1a0')),
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      "user_id": userId,
      "pageno": pageNo,
      "daterange": dateRange,
    });

    notifyListeners();

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Response Data: ${response.body}");
        print("Response Data: ${response.body}");
        final List<dynamic> list = data['list'];
        _tripHistoryList =
            list.map((item) => TripHistory.fromJson(item)).toList();
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        _tripHistoryList = [];
      }
    } catch (error) {
      print("Error fetching trip history: $error");
      _tripHistoryList = [];
    }

    notifyListeners();
  }


}
  
