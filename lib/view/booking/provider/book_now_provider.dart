import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/drop_location_history.dart';
import 'package:flutter_easy_ride/service/api_helper.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/view/booking/models/common_model.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookNowProvider with ChangeNotifier {
  final addList = [
    CommonModel(title: "Home", image: AppImage.home),
    CommonModel(title: "Office", image: AppImage.office),
    CommonModel(title: "Add New", image: AppImage.pluse),
  ];

  List<TextEditingController> controllerList = [];

  List<CommonTextField> locationTextfieldList = [];

  void addLocations() {
    final con = TextEditingController();
    controllerList.insert(controllerList.length - 1, con);
    locationTextfieldList.insert(
      locationTextfieldList.length - 1,
      CommonTextField(
        hintText: "Enter location",
        con: con,
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
      ),
    );
    notifyListeners();
  }

  /// Remove Extra Location Field
  List<int> emptyLocationList = [];
  removeExtraLocation() {
    if (locationTextfieldList.isNotEmpty) {
      for (int i = 0; i < locationTextfieldList.length; i++) {
        if (locationTextfieldList[i].con?.text.trim().isEmpty ?? false) {
          emptyLocationList.add(i);
        }
      }
    }
    if (emptyLocationList.isNotEmpty) {
      emptyLocationList.forEach((e) => locationTextfieldList.removeAt(e));
    }
    notifyListeners();
  }

  /// Add Source and Destination Location
  addLocationTextFields(TextEditingController sourceLocation, TextEditingController destination, String address) {
    controllerList.add(sourceLocation);
    controllerList.add(destination);
    sourceLocation.text = address;
    locationTextfieldList.addAll([
      CommonTextField(
        hintText: "Source",
        con: sourceLocation,
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
      ),
      CommonTextField(
        hintText: "Destination",
        con: destination,
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
      )
    ]);
    notifyListeners();
  }

  /// On Map Tap
  Set<Marker> markers = {};
  addLocationMarkers(LatLng l) {
    final markerId = MarkerId('marker_${markers.length}');
    final marker = Marker(
      markerId: markerId,
      position: l,
      infoWindow: InfoWindow(title: 'Marker ${markers.length + 1}'),
    );
    markers.add(marker);
    notifyListeners();
  }

  /// Get Current Location
  TextEditingController homeSearchCon = TextEditingController();
  LatLng? _currentLocation;
  bool _isLoading = false;

  LatLng? get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  Future<void> fetchCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check for location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      Position position =
          await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

      // Update the current location
      _currentLocation = LatLng(position.latitude, position.longitude);
      List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      ALatitude = position.latitude;
      ALongitude = position.longitude;
      address =
          '${placeMarks[0].thoroughfare}, ${placeMarks[0].subLocality}, ${placeMarks[0].locality}, ${placeMarks[0].administrativeArea}, ${placeMarks[0].postalCode}';
      homeSearchCon.text = address;
      if (_currentLocation != null) {
        addLocationMarkers(_currentLocation!);
      }
    } catch (e) {
      print('Error fetching location: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  HistoryResponse? historyResponse;
  List<DropLocation>? get nearByLocationList => historyResponse?.list ?? [];
  bool loadDropLocation = false;

  Future<void> getDropHistoryList() async {
    try {
      loadDropLocation = true;
      notifyListeners();
      final response = await NetworkUtility.sendGetRequest(ApiHelper.dropLocationHistory);
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        historyResponse = HistoryResponse.fromJson(jsonData);
        loadDropLocation = false;
        notifyListeners();
      } else {
        loadDropLocation = false;
        notifyListeners();
      }
    } catch (e) {
      loadDropLocation = false;
      notifyListeners();
    }
  }

  resetAllData() {
    controllerList.forEach((e) => e.dispose);
    locationTextfieldList.clear();
    historyResponse = null;
    nearByLocationList?.clear();
  }
}
