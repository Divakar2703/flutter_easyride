import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/driver_details.dart';
import 'package:flutter_easy_ride/model/drop_location_history.dart';
import 'package:flutter_easy_ride/model/vehicle_data.dart';
import 'package:http/http.dart'as http;
import '../../model/autocomplate_prediction.dart';
import '../../model/coupon_data.dart';
import '../../model/place_auto_complate_response.dart';
import '../../service/api_helper.dart';
import '../../service/network_utility.dart';
import '../../utils/eve.dart';
import '../../utils/local_storage.dart';


class CabBookProvider with ChangeNotifier {
  String? _pickupLocation;
  String _dropLocation="";
  bool isLoading = true;
  List<AutocompletePrediction> placePredictions = [];
  List<AutocompletePrediction> pickPlacePredictions = [];
  final List<Vehicle> vehicle=[];
  CouponData? couponData;

  VehicleResponse? vehicleResponse;
  DriverDetails? driverInfo;
  HistoryResponse? historyResponse;
  //final String apiKey = 'AIzaSyAlcZM-RHySJIQmUwOaJmJCVPZcuMKS70Y'; // Replace with your Google API Key
final String apiKey='AIzaSyAKgqAyTO5G0rIf8laUc5_gOaF16Qwjg2Y';
  String? get pickupLocation => _pickupLocation;
  String? get dropLocation => _dropLocation;
  VehicleResponse? get vehicleRes => vehicleResponse;
  DriverDetails ? get driverdetails => driverInfo;
  HistoryResponse ? get dropHistoryData => historyResponse;


  void getCurrentLocation(){
    _pickupLocation=address;
    notifyListeners();
  }

  void setDropLocation(String location,double lat,double long) {
    _dropLocation = location;
    dropLat=lat;
    dropLong=long;
    notifyListeners();
  }

  void setPickupLocation(String location) {
    _pickupLocation = location;
    notifyListeners();
  }

  void setCabType(String type){

    cabType=type;
    notifyListeners();

  }

  void placeAutoComplete(String query,String location) async {
    Uri uri =
    Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": apiKey,
    });
    String? response = await NetworkUtility.fetchGetUrl(uri);
    print(response);
    if (response != null) {
      PlaceAutocompleteResponse result =
      PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        if(location=="Pickup"){
          pickPlacePredictions=result.predictions!;
          notifyListeners();
        }
        else{
          placePredictions = result.predictions!;
          print("places===${placePredictions.length}");
          notifyListeners();

        }

      }
    }
  }
  void getDropLocation(String location){
    _dropLocation=location;
    notifyListeners();
  }
  void getPickupLocation(String location){
    _pickupLocation=location;
    notifyListeners();
  }
  // Future<void> getVehicleData() async {
  //
  //   Map<String, dynamic> requestBody = {
  //     "pickup_lat": ALatitude,
  //     "pickup_long": ALongitude,
  //     "drop_lat": dropLat,
  //     "drop_long": dropLong
  //   };
  //
  //   try {
  //     final response = await NetworkUtility.sendPostRequest(
  //       ApiHelper.getVehicle,
  //        requestBody,
  //     );
  //     print('Response body: ${response.body}');
  //     Map<String,dynamic> jsondataa=jsonDecode(response.body);
  //
  //     if (response.statusCode == 200) {
  //       VehicleResponse response=VehicleResponse.fromJson(jsondataa);
  //       vehicleResponse=response;
  //       notifyListeners();
  //     } else {
  //       print('Error: ${response.statusCode}, ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error sending POST request: $e');
  //     // Handle any exception
  //   }

  Future<void> getVehicleData() async {
    Map<String, dynamic> requestBody = {
      "pickup_lat": ALatitude,
      "pickup_long": ALongitude,
      "drop_lat": dropLat,
      "drop_long": dropLong
    };

    try {
      final response = await NetworkUtility.sendPostRequest(
        ApiHelper.getVehicle,
        requestBody,
      );
      print('Response body: ${response.body}');
      Map<String, dynamic> jsondataa = jsonDecode(response.body);

      if (response.statusCode == 200) {
        VehicleResponse vehicleResponse = VehicleResponse.fromJson(jsondataa);

        // Check if type is empty and filter accordingly
        List<Vehicle> filteredVehicles = vehicleResponse.vehicle.where((vehicle) {
          // If cabType is empty, include all vehicles; otherwise, filter by type
          return cabType.isEmpty || vehicle.type == cabType;
        }).toList();

        // Update the response with filtered data
        vehicleResponse = VehicleResponse(
          vehicle: filteredVehicles,
          status: vehicleResponse.status,
          message: vehicleResponse.message,
          statusCode: vehicleResponse.statusCode,
        );

        // Notify listeners with filtered data
        this.vehicleResponse = vehicleResponse;
        notifyListeners();
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
  }

  Future<void> sendRequestToDriver(double pickLat,double pickLong,double dropLat,double dropLong,int vehicleID,String pickupAddress,String dropAddress) async {
    // Request body
    Map<String, dynamic> requestBody = {
      "pickup_lat": pickLat,
      "pickup_long":pickLong ,
      "drop_lat" : dropLat,
      "drop_long" : dropLong,
      "vehicle_type_id" : vehicleID,
      "user_id" : 259 ,
      "added_by_web" : "asatvindia.in" ,
      "pickup_address" : pickupAddress ,
      "drop_address": dropAddress
    };

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.sendRequestDriver, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {

      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> findDriver(int vehicleID) async {
    // Request body
    Map<String, dynamic> requestBody = {
      "vehicle_type_id":vehicleID,
      "user_id":259
    };
    print("requestbody==${requestBody}");

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.findDriver, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsondata=jsonDecode(response.body);
         driverInfo=DriverDetails.fromJson(jsondata);
        print("driverdata===${driverInfo}");
        notifyListeners();
        isLoading=false;

      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> bookCab(int requestID,String bookID,String paymentType,String orderID,String transID,double amount,double conCharge,) async {
    // Request body
    Map<String, dynamic> requestBody = {
      "send_request_id":requestID,
      "user_id":259,
      "added_by_web":"www.bits.teamtest.co.in",
      "booking_id":bookID,
      "paymenttype":paymentType,
      "order_id":orderID,
      "tarns_id":transID,
      "TXN_AMOUNT":amount,
      "conv_charge":conCharge,
      "user_phone":"7505145405"
    };

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.bookCab, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {

      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> CancelCab(int requestID,String bookID,String paymentType,String orderID,String transID,double amount,double conCharge,) async {
    // Request body
    Map<String, dynamic> requestBody = {
      "send_request_id":requestID,
      "user_id":259,
      "added_by_web":"www.bits.teamtest.co.in",
      "booking_id":bookID,
      "paymenttype":paymentType,
      "order_id":orderID,
      "tarns_id":transID,
      "TXN_AMOUNT":amount,
      "conv_charge":conCharge,
      "user_phone":"7505145405"
    };

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.cancelBookCab, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {

      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> paynow(int requestID,String paymentType,double conCharge,) async {
    // Request body
    Map<String, dynamic> requestBody = {
      "send_request_id":requestID,
      "added_by_web":"www.bits.teamtest.co.in",
      "user_id":259,
      "paymenttype":paymentType, //online,codd,wallet
      "conv_charge":conCharge
    };

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.payNow, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {

      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> paymentVerify(int requestID,String paymentType,double conCharge,) async {
    // Request body
    Map<String, dynamic> requestBody = {
      "user_id":259,
      "pageno":1,
      "daterange":"2024/10/28 - 2024/10/29"
    };

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.paymentVerify, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {

      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> getDropHistoryList() async {
    try {
      final response = await NetworkUtility.sendGetRequest(ApiHelper.dropLocationHistory,);
      print('Response body: ${response.body}');
      Map<String,dynamic> jsondataa=jsonDecode(response.body);

      if (response.statusCode == 200) {
         historyResponse=HistoryResponse.fromJson(jsondataa);
        print("response===${historyResponse}");
         isLoading=false;
        notifyListeners();
        // Handle success response
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> addDropLocation(String dropLat,String dropLong,String dropAddress,String bookingType) async {
    Map<String, dynamic> requestBody = {
      "drop_lat": dropLat,
      "drop_long": dropLong,
      "drop_address":dropAddress,
      "booking_type":bookingType
    };
    try {

      final response = await NetworkUtility.sendPostRequest(ApiHelper.dropLocationHistory,requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading=false;
        notifyListeners();
        // Handle success response
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> deleteDropLocation(String dropID) async {

    Map<String, dynamic> requestBody = {
      "autoid": int.parse(dropID),
    };
    try {

      final response = await NetworkUtility.sendPostRequest(ApiHelper.deleteDropLocation,requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading=false;
        getDropHistoryList();
        notifyListeners();
        // Handle success response
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }
  Future<void> getOffers(int vehicleID) async {

    Map<String, dynamic> requestBody = {
      "pickup_lat": ALatitude,
      "pickup_long": ALongitude,
      "drop_lat": dropLat,
      "drop_long": dropLong,
      "vehicletype_id":vehicleID    };
    try {

      final response = await NetworkUtility.sendPostRequest(ApiHelper.getOffers,requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading=false;
        var jsondata=jsonDecode(response.body);
         couponData=CouponData.fromJson(jsondata);
        getDropHistoryList();
        notifyListeners();
        // Handle success response
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }

}
