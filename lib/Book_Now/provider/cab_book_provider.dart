import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/vehicle_data.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart'as http;

import '../../model/autocomplate_prediction.dart';
import '../../model/place_auto_complate_response.dart';
import '../../service/api_helper.dart';
import '../../service/network_utility.dart';
import '../../utils/eve.dart';
import '../../utils/local_storage.dart';

class CabBookProvider with ChangeNotifier {
  String? _pickupLocation;
  String _dropLocation="";


  List<AutocompletePrediction> placePredictions = [];
  List<AutocompletePrediction> pickPlacePredictions = [];
  VehicleResponse? vehicleResponse;


  final String apiKey = 'AIzaSyAlcZM-RHySJIQmUwOaJmJCVPZcuMKS70Y'; // Replace with your Google API Key

  String? get pickupLocation => _pickupLocation;
  String? get dropLocation => _dropLocation;
  VehicleResponse? get vehicleRes => vehicleResponse;

  void getCurrentLocation(){
    _pickupLocation=address;
    notifyListeners();
  }

  void setDropLocation(String location) {
    _dropLocation = location;
    notifyListeners();
  }

  void setPickupLocation(String location) {
    _pickupLocation = location;
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

  Future<void> getVehicleData() async {
    // URL and credentials
    final String url = ApiHelper.getVehicle;
    print("url==$url");
    final String username = await LocalStorage.getUsername(); // Replace with your username
    final String password = await LocalStorage.getPassword(); // Replace with your password
print("username==${username}, pass=${password}");

    // Request body
    Map<String, dynamic> requestBody = {
      "pickup_lat": 24.856874349764823,
      "pickup_long": 74.61273737259009,
      "drop_lat": 24.858874743013917,
      "drop_long": 74.61150946823327
    };

    // Encoding credentials for basic authentication
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    // Making the POST request
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(requestBody),
      );
      print('Response body: ${response.body}');
      Map<String,dynamic> jsondataa=jsonDecode(response.body);

      if (response.statusCode == 200) {
        VehicleResponse response=VehicleResponse.fromJson(jsondataa);
        vehicleResponse=response;
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



