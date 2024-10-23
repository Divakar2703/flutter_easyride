import 'dart:convert';

import 'package:flutter_easy_ride/model/tripdetailsmodel.dart';
import 'package:http/http.dart' as http;

class TripHistrydetailService {
  final String apiUrl =
      "https://asatvindia.in/cab/Api/User/trip_history_details";

  Future<Histrydetailsmodel> fetchTripDetails() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      return Histrydetailsmodel.formjson(json);
    } else {
      throw Exception('Failed to load trip details');
    }
  }
}
  