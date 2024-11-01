import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/book_easyride/model/histrydetails.dart';
import 'package:flutter_easy_ride/service/api_helper.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import 'package:http/http.dart' as http;

import '../../model/vehicle_data.dart';
import '../../utils/local_storage.dart';

class TripHistrydetailsproviders with ChangeNotifier {
  TripHistryModel? tripHistryModel;
  TripHistryModel? get tripHistryModels => tripHistryModel;

  List<VehicleResponse>? response = [];
  List<VehicleResponse>? get VehicleResponses => response;

  Future<void> featchData(String booking_id) async {
    final url = "https://asatvindia.in/cab/Api/User/trip_history_details";

    final response = await http.get(Uri.parse('url'));

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('${response.body}');

        print('${response.body}');
      } else {
        print('data is not featch please do correct code ');
      }
    } catch (Error) {
      throw ('Please do correct code');
    }

// {
// "userid":10,
// "rating":5,
// "feedback":"Very nice service",
// "driver_id":15
// }
    Future<void> feedbackpost(
        String UserID, String Rating, String Feedback, String DriverID) async {
      Map<String, dynamic> requestBody = {
        UserID: "userid",
        Rating: "rating",
        Feedback: "feedback",
        DriverID: "driver_id",
      };

      // try{

      //   final response = await NetworkUtility.

      // }catch(Error){

      // }
    }
  }
}
