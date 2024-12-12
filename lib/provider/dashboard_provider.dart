import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easy_ride/model/dashboard.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import 'package:flutter_easy_ride/utils/eve.dart';

import '../model/booking.dart';
import '../model/nearby_vehicle.dart';
import '../model/vehicle_data.dart';
import '../service/api_helper.dart';
import 'package:http/http.dart'as http;

class DashboardProvider extends ChangeNotifier
{

  bool loading=false;
  DashboardResponse? dashboardResponse;
  NearByVehicle? vehicleResponse;
  DashboardResponse? get dashboard=>dashboardResponse;
  List<Booking> bookinglist=[];
  NearByVehicle? get vehicleData=>vehicleResponse;



  Future<void> fetchDashboard() async {
    loading=true;
    final String url = ApiHelper.dashboard;

    try {
      final response = await NetworkUtility.sendGetRequest(
        url,
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        loading=false;
        var jsondata=jsonDecode(response.body);
         dashboardResponse=DashboardResponse.fromJson(jsondata);
         notifyListeners();
      } else {
        loading=false;
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      loading=false;
      print('Error sending POST request: $e');
    }
  }

  Future<void> pendingBooking() async {
    loading=true;
    final String url = ApiHelper.cab_request_on_user_id;
    var params={
      "user_id":15
    };

    try {
      final response = await NetworkUtility.sendPostRequest(
        url,params
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        loading=false;
        var jsondata=jsonDecode(response.body);
        final List<dynamic> list = jsondata["list"];

        // Convert to List<Booking>

       // List<Booking> bookings
       bookinglist = list.map((item) => Booking.fromJson(item)).toList();

        // Filter by entry_date
     //   bookinglist = bookings.where((booking) => booking.entryDate.startsWith('13/11/2024 13:10 PM')).toList();
        print("bookinglist==${bookinglist}");
        notifyListeners();
      } else {
        loading=false;
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      loading=false;
      print('Error sending POST request: $e');
    }
  }

  Future<void> getLocationVehicles() async {
    loading=true;
    final String url = ApiHelper.nearbyVehicles;
    var params={
    "pickup_lat": 30.368341,
    "pickup_long": 78.0516939
    };
    print("params==${params}");

    try {
      final response = await NetworkUtility.sendPostRequest(
          url,params
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        loading=false;
        var jsondata=jsonDecode(response.body);
         vehicleResponse = NearByVehicle.fromJson(jsondata);
        notifyListeners();
      } else {
        loading=false;
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      loading=false;
      print('Error sending POST request: $e');
    }
  }



}