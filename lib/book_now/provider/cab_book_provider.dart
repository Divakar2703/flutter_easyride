import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/screens/select_vehicle.dart';
import 'package:flutter_easy_ride/Pre_Booking/screens/confirm_booking_screen.dart';
import 'package:flutter_easy_ride/main.dart';
import 'package:flutter_easy_ride/model/booking_request.dart';
import 'package:flutter_easy_ride/model/driver_details.dart';
import 'package:flutter_easy_ride/model/drop_location_history.dart';
import 'package:flutter_easy_ride/model/vehicle_data.dart';
import 'package:flutter_easy_ride/service/LocationApiUtils.dart';

import '../../Pre_Booking/model/notes.dart';
import '../../Pre_Booking/model/payment.dart';
import '../../model/autocomplate_prediction.dart';
import '../../model/coupon_data.dart';
import '../../model/location_suggetions.dart';
import '../../service/api_helper.dart';
import '../../service/network_utility.dart';
import '../../utils/eve.dart';

class CabBookProvider with ChangeNotifier {
  String? _pickupLocation;
  String _dropLocation = "";
  int selectedInstructionIndex = -1;
  bool isLoading = true;
  List<AutocompletePrediction> placePredictions = [];
  List<AutocompletePrediction> pickPlacePredictions = [];
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropController = TextEditingController();
  List<Suggestion> suggetions = [];
  final List<Vehicle> vehicle = [];
  CouponData? couponData;
  Notes? notes;
  String? bookingStatus;

  Notes? get notesdetails => notes;
  Payment? paytype;
  Payment? get paytypes => paytype;

  VehicleResponse? vehicleResponse;
  DriverDetails? driverInfo;
  HistoryResponse? historyResponse;
  BookingRequest? bookingReq;
  //final String apiKey = 'AIzaSyAlcZM-RHySJIQmUwOaJmJCVPZcuMKS70Y'; // Replace with your Google API Key
  final String apiKey = 'AIzaSyDzwtZHoEVgjThw18yh2qLCkO-hvPE6i94';
  String? get pickupLocation => _pickupLocation;
  String? get dropLocation => _dropLocation;
  VehicleResponse? get vehicleRes => vehicleResponse;
  DriverDetails? get driverdetails => driverInfo;
  HistoryResponse? get dropHistoryData => historyResponse;
  BookingRequest? get bookingRequest => bookingReq;
  String? get confirmBookingStatus => bookingStatus;

  // SuggestionsResponse ? get suggestions=>suggestionsResponse;

  void getCurrentLocation() {
    _pickupLocation = address;
    notifyListeners();
  }

  void setDropLocation(String location, double lat, double long) {
    _dropLocation = location;
    dropAddress = location;
    dropLat = lat;
    dropLong = long;
    notifyListeners();
  }

  void setPickupLocation(String location) {
    _pickupLocation = location;
    notifyListeners();
  }

  void setCabType(String type) {
    cabType = type;
    notifyListeners();
  }

  void setSelectedVehicle(String id) {
    print("selctud==$id");
    selectedVehicle = id;
    notifyListeners();
  }

  // notes
  void setSelectedInstruction(int index) {
    selectedInstructionIndex = index;
    notifyListeners();
  }

  void placeAutoComplete(String query, String location) async {
    // Uri uri =
    // Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
    //   "input": query,
    //   "key": apiKey,
    // });
    // String? response = await NetworkUtility.fetchGetUrl(uri);
    // print(response);
    // if (response != null) {
    //   PlaceAutocompleteResponse result =
    //   PlaceAutocompleteResponse.parseAutocompleteResult(response);
    //   if (result.predictions != null) {
    //     if(location=="Pickup"){
    //       pickPlacePredictions=result.predictions!;
    //       notifyListeners();
    //     }
    //     else{
    //       placePredictions = result.predictions!;
    //       print("places===${placePredictions.length}");
    //       notifyListeners();
    //
    //     }
    //
    //   }
    // }

    _dropLocation = query;
    var jsondata = await LocationUtils.searchPlaces(query);
    SuggestionsResponse suggestionsResponse = SuggestionsResponse.fromJson(jsondata);
    suggetions = suggestionsResponse.suggestions;
    notifyListeners();
  }

  Future<void> getDropLocation(String location, String placeID, String booking_type) async {
    _dropLocation = location;
    Map<String, dynamic> data = await LocationUtils.getPlaceDetails(placeID);
    dropAddress = data["formattedAddress"];
    dropLat = data["location"]["latitude"];
    dropLong = data["location"]["longitude"];
    if (dropAddress != "" && booking_type == "BookNow") {
      Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => SelectVehicle()));
    }
    notifyListeners();
  }

  Future<void> getPickupLocation(String location, String placeID, String booking_type) async {
    _pickupLocation = location;
    Map<String, dynamic> data = await LocationUtils.getPlaceDetails(placeID);
    address = data["formattedAddress"];
    ALatitude = data["location"]["latitude"];
    ALongitude = data["location"]["longitude"];

    notifyListeners();
  }

  Future<void> getVehicleData() async {
    Map<String, dynamic> requestBody = {
      "pickup_lat": ALatitude,
      "pickup_long": ALongitude,
      "drop_lat": dropLat,
      "drop_long": dropLong
    };
    print("params===${requestBody}");

    try {
      final response = await NetworkUtility.sendPostRequest(
        ApiHelper.getVehicle,
        requestBody,
      );
      print('Response body: ${response.body}');
      Map<String, dynamic> jsondataa = jsonDecode(response.body);

      if (response.statusCode == 200) {
        VehicleResponse vehicleResponse = VehicleResponse.fromJson(jsondataa);
        if (vehicleResponse.status == "success") {
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
          print("no data found");
          notifyListeners();
        }
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
  }

  Future<void> sendRequestToDriver(String vehicleid, String bookingType) async {
    print("vehicleID==${selectedVehicle}");
    // Request body
    Map<String, dynamic> requestBody = {
      "pickup_lat": ALatitude,
      "pickup_long": ALongitude,
      "drop_lat": dropLat,
      "drop_long": dropLong,
      "vehicle_type_id": vehicleid,
      "user_id": userID,
      "added_by_web": "asatvindia.in",
      "pickup_address": address,
      "drop_address": dropAddress,
      "booking_type": bookingType
    };

    print("params====${requestBody}");

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.sendRequestDriver, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);

        bookingReq = BookingRequest.fromJson(jsondata);
        notifyListeners();
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
  }

  Future<void> findDriver(int vehicleID) async {
    // Request body
    Map<String, dynamic> requestBody = {"vehicle_type_id": vehicleID, "user_id": userID};
    print("requestbody==${requestBody}");

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.findDriver, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        driverInfo = DriverDetails.fromJson(jsondata);
        print("driverdata===${driverInfo}");
        notifyListeners();
        isLoading = false;
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }

  Future<void> bookCab(
    int requestID,
    String paymentType,
    String transID,
    double amount,
    double conCharge,
  ) async {
    // Request body
    Map<String, dynamic> requestBody = {
      "send_request_id": requestID,
      "user_id": userID,
      "added_by_web": "www.bits.teamtest.co.in",
      "booking_id": bookingID,
      "paymenttype": paymentType,
      "order_id": orderID,
      "tarns_id": transID,
      "TXN_AMOUNT": amount,
      "conv_charge": conCharge,
      "user_phone": "7505145405",
      "booking_type": BookingType
    };

    print("params==${requestBody}");

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.bookCab, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        transactionID = "";
        var jsondata = jsonDecode(response.body);
        var status = jsondata["status"];
        if (status == "success") {
          bookingStatus = status;
          requestStatus = false;
          Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => BookingSuccessScreen()));
          notifyListeners();
        }
      } else {
        transactionID = "";
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }

  Future<void> CancelCab(
    int requestID,
    String bookID,
    String paymentType,
    String orderID,
    String transID,
    double amount,
    double conCharge,
  ) async {
    // Request body
    Map<String, dynamic> requestBody = {"booking_id": bookingID, "reason": "plan changed", "user_phone": "8238375356"};

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

  Future<void> paynow(
    int requestID,
    String paymentType,
    double conCharge,
  ) async {
    // Request body
    isLoading = true;
    Map<String, dynamic> requestBody = {
      "send_request_id": requestID,
      "added_by_web": "www.bits.teamtest.co.in",
      "user_id": userID,
      "paymenttype": paymentType, //online,codd,wallet
      "conv_charge": conCharge
    };
    print("req===${requestBody}");

    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.payNow, requestBody);
      print('Paynow Response body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        var jsondata = jsonDecode(response.body);
        var orderid = jsondata["order_id"];
        orderID = orderid;
        var bookingid = jsondata["booking_id"];
        bookingID = bookingid;
        print("bookingid==$bookingID");
        notifyListeners();
      } else {
        isLoading = false;
        print('Error: ${response.statusCode}, ${response.body}');
        // Handle error response
      }
    } catch (e) {
      isLoading = false;
      print('Error sending POST request: $e');
      // Handle any exception
    }
  }

  Future<void> paymentVerify(
    int requestID,
    String paymentType,
    double conCharge,
  ) async {
    // Request body
    Map<String, dynamic> requestBody = {"user_id": userID, "pageno": 1, "daterange": "2024/10/28 - 2024/10/29"};

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
      final response = await NetworkUtility.sendGetRequest(
        ApiHelper.dropLocationHistory,
      );
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        historyResponse = HistoryResponse.fromJson(jsonData);
        isLoading = false;
        notifyListeners();
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
  }

  Future<void> addDropLocation(String dropLat, String dropLong, String dropAddress, String bookingType) async {
    Map<String, dynamic> requestBody = {
      "drop_lat": dropLat,
      "drop_long": dropLong,
      "drop_address": dropAddress,
      "booking_type": bookingType
    };
    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.dropLocationHistory, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
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
      final response = await NetworkUtility.sendPostRequest(ApiHelper.deleteDropLocation, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
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
      "vehicletype_id": vehicleID
    };
    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.getOffers, requestBody);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        var jsondata = jsonDecode(response.body);
        if (jsondata["status"] == "error") {
          notifyListeners();
        } else {
          couponData = CouponData.fromJson(jsondata);
          getDropHistoryList();
          notifyListeners();
        }

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

  Future<void> GetNotes() async {
    try {
      final response = await NetworkUtility.sendGetRequest(ApiHelper.getnotes);
      if (response.statusCode == 200) {
        print('(${response.statusCode})');
        var jsondata = jsonDecode(response.body);
        notes = Notes.fromJson(jsondata);
        print(notes);
        print(response.body);
      } else {
        print('Error Data is not found');
      }
    } catch (Error) {}
  }

  Future<void> convcharge() async {
    Map<String, dynamic> requestbody = {};
    try {
      final response = await NetworkUtility.sendPostRequest(ApiHelper.payment, requestbody);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        paytype = Payment.fromJson(jsondata);
        print(response.body);
      } else {
        print('Error please check  your code');
      }
    } catch (Error) {
      throw 'Error Data is not found';
    }
  }
}
