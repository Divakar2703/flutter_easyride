import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Pre_Booking/model/finddriver.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import '../../service/api_helper.dart';
import '../model/requestdriver.dart';

class PreebookingProvider with ChangeNotifier {
  DriverRequest? driverRequest;
  DriverRequest? get driverinfo => driverRequest;
  FindDriver? findDriver;
  FindDriver? get findDriverinfo => findDriver;

  var data1;
  var getPreevehicle1;
  Future<void> confirmpreebook() async {
    Map<String, dynamic> requestbody = {
      "pickup_lat": 18.4848933,
      "pickup_long": 73.9369676,
      "drop_lat": 27.210052664323,
      "drop_long": 83.891678676009,
      "added_by_web": "asatvindia.in",
      "pickup_address":
          "Dr. Shyamu medical store, Turkaha, Uttar Pradesh 2 74801, India",
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

  Future<void> getprebookvehicle() async {
    Map<String, dynamic> requestbody = {
      "pickup_lat": 24.856874349764823,
      "pickup_long": 74.61273737259009,
      "drop_lat": 24.858874743013917,
      "drop_long": 74.61150946823327
    };

    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.getPreebookvehicle, requestbody);

      if (response.statusCode == 200) {
        var getPreevehicle = jsonDecode(response.body);
        getPreevehicle1 = getPreevehicle;
        print(getPreevehicle);

        print(response.body);
      } else {
        print('Please check your data');
      }
    } catch (Error) {
      throw 'Error please do code';
    }
  }

  Future<void> SendpreebookrequestDriver(
      double pickLat,
      double pikLong,
      double dropLong,
      int vehicleID,
      String pickupaddress,
      String dropAddress) async {
    Map<String, dynamic> requestBody = {
      "pickup_lat": pickLat,
      "pickup_long": pikLong,
      "drop_lat": dropLong,
      "drop_long": 83.891678676009,
      "vehicle_type_id": vehicleID,
      "user_id": 6,
      "added_by_web": "asatvindia.in",
      "pickup_address": pickupaddress,
      "drop_address": dropAddress,
    };

    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.sendRequestDriverpreebook, requestBody);

      if (response.statusCode == 200) {
        var jsondataa = jsonDecode(response.body);
        driverRequest = DriverRequest.fromJson(jsondataa);
        print(response.body);
      } else {
        print('Please check  you code it is so error');
      }
    } catch (Error) {
      print('Error  please do correct code  ${Error}');
    }
  }

  Future<void> finddriver(int VehicleID) async {
    Map<String, dynamic> requestBody = {"vehicle_type_id": 10, "user_id": 5};
    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.finddriverpreebook, requestBody);
      if (response.body == 200) {
        var jsondata = jsonDecode(response.body);
        findDriver = FindDriver.fromJson(jsondata);
        print(response.body);
      } else {
        print('Please do you code');
      }
    } catch (Error) {
      print(' Error please  do correct');
    }
  }

  Future<void> PreebookCab(int requestID, String bookID, String paymentType,
      String orderID, String transID, double amount, double conCharge) async {
    Map<String, dynamic> requestBody = {
      "send_request_id": requestID,
      "user_id": 259,
      "added_by_web": "www.bits.teamtest.co.in",
      "booking_id": bookID,
      "paymenttype": paymentType,
      "order_id": orderID,
      "tarns_id": transID,
      "TXN_AMOUNT": amount,
      "conv_charge": conCharge,
      "user_phone": "7505145405"
    };

    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.preebookCab, requestBody);

      if (response.statusCode == 200) {
        var preebook = jsonDecode(response.body);
        print(preebook);
        print(response.body);
        print('(${response.statusCode})');
      }
    } catch (Error) {}
  }

  Future<void> Cancialpreebook(
      String BookID, String reason, int usenumber) async {
    Map<String, dynamic> requestbody = {
      "booking_id": BookID,
      "reason": reason,
      "user_phone": usenumber,
    };

    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.cancelpreebooingvehicle, requestbody);
      if (response.statusCode == 200) {
        var cancialbook = jsonDecode(response.body);
        notifyListeners();
        print('${response.statusCode}');
        print(response.body);

        print(cancialbook);
      } else {
        print('Pleace check you code ');
      }
    } catch (Error) {
      throw 'Error please check code';
    }
  }

}
