import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/model/drop_location_history.dart';
import 'package:flutter_easy_ride/model/location_suggetions.dart';
import 'package:flutter_easy_ride/service/api_helper.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/view/booking/models/common_model.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookNowProvider with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  String? bookType = "";
  GoogleMapController? mapController;

  chooseDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void updateCameraView() {
    if (markerPositions.length >= 2 && mapController != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          markerPositions[0].latitude < markerPositions[1].latitude
              ? markerPositions[0].latitude
              : markerPositions[1].latitude,
          markerPositions[0].longitude < markerPositions[1].longitude
              ? markerPositions[0].longitude
              : markerPositions[1].longitude,
        ),
        northeast: LatLng(
          markerPositions[0].latitude > markerPositions[1].latitude
              ? markerPositions[0].latitude
              : markerPositions[1].latitude,
          markerPositions[0].longitude > markerPositions[1].longitude
              ? markerPositions[0].longitude
              : markerPositions[1].longitude,
        ),
      );

      mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100), // 100 is padding
      );
    }
  }

  _onLocationChange(LatLng l) {
    if (mapController != null) {
      mapController?.animateCamera(CameraUpdate.newLatLng(l));
    }
    updateCameraView();
    notifyListeners();
  }

  final kmList = [
    CommonModel(title: "1 Hr", subTitle: "10 km", isSelected: false),
    CommonModel(title: "2 Hr", subTitle: "20 km", isSelected: false),
    CommonModel(title: "3 Hr", subTitle: "30 km", isSelected: false),
    CommonModel(title: "4 Hr", subTitle: "40 km", isSelected: false),
    CommonModel(title: "5 Hr", subTitle: "50 km", isSelected: false),
    CommonModel(title: "6 Hr", subTitle: "60 km", isSelected: false),
    CommonModel(title: "7 Hr", subTitle: "70 km", isSelected: false),
  ];

  choosePackage(int i) {
    kmList.forEach((e) => e.isSelected = false);
    kmList[i].isSelected = true;
    notifyListeners();
  }

  List<TextEditingController> controllerList = [];

  List<CommonTextField> locationTextfieldList = [];

  final dio = getIt.get<DioClient>();

  void addLocations() {
    final con = TextEditingController();
    controllerList.insert(controllerList.length - 1, con);
    locationTextfieldList.insert(
      locationTextfieldList.length - 1,
      CommonTextField(
        hintText: "Enter location",
        con: con,
        border: InputBorder.none,
        suffix: SvgPicture.asset(AppImage.remove),
        contentPadding: EdgeInsets.all(10),
        onTap: () => setSelectedController(con),
        onChanged: (v) => searchLocation(v),
        suffixOnTap: () => removeLocation(con),
      ),
    );
    notifyListeners();
  }

  /// On Map Tap & add marker
  Set<Marker> markers = {};
  Future<void> addLocationMarkers(LatLng l, String address, {bool isSource = false, bool isDestination = false}) async {
    try {
      final markerId = MarkerId(isSource
              ? 'source_marker'
              : isDestination
                  ? 'destination_marker'
                  : 'marker_${markers.length}' // Unique ID for other markers
          );

      final BitmapDescriptor icon = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(10, 10)),
        isDestination ? AppImage.destination : AppImage.source,
      );
      await Future.delayed(Duration(milliseconds: 500));
      if (isSource) {
        markers.removeWhere((m) => m.markerId.value == 'source_marker');

        if (markerPositions.isNotEmpty) {
          markerPositions[0] = l;
        } else {
          markerPositions.insert(0, l);
        }
      } else if (isDestination) {
        markers.removeWhere((m) => m.markerId.value == 'destination_marker');

        if (markerPositions.length > 1) {
          markerPositions[markerPositions.length - 1] = l;
        } else {
          markerPositions.add(l);
        }
      } else {
        if (markerPositions.length > 1) {
          markerPositions.insert(markerPositions.length - 1, l);
        } else {
          markerPositions.add(l);
        }
      }

      markers.add(
        Marker(
            markerId: markerId,
            position: l,
            icon: icon,
            anchor: Offset(0.5, 0.5),
            infoWindow: InfoWindow(title: address)),
      );

      _onLocationChange(l);
      if (markerPositions.length >= 2) {
        _drawPolyline();
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  /// Remove Location Textfield
  int count = 1;
  void removeLocation(TextEditingController con) {
    String removeMarkId = "";
    int indexToRemove = controllerList.indexOf(con);
    if (indexToRemove != -1) {
      controllerList.removeAt(indexToRemove);
      markers.forEach((m) {
        if (m.infoWindow.title == locationTextfieldList[indexToRemove].con?.text) {
          removeMarkId = m.markerId.value;
        }
      });
      locationTextfieldList.removeAt(indexToRemove);
      if (locationTextfieldList[indexToRemove].con != con && indexToRemove < markerPositions.length) {
        markerPositions.removeAt(indexToRemove);
      }
      markers.removeWhere((m) => m.markerId.value == removeMarkId);
      _drawPolyline();
      updateCameraView();
      notifyListeners();
    }
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
        onTap: () => setSelectedController(sourceLocation),
        onChanged: (v) => searchLocation(v),
        contentPadding: EdgeInsets.all(10),
      ),
      CommonTextField(
        hintText: "Destination",
        con: destination,
        border: InputBorder.none,
        onTap: () => setSelectedController(destination),
        onChanged: (v) => searchLocation(v),
        contentPadding: EdgeInsets.all(10),
      )
    ]);
    notifyListeners();
  }

  /// Draw Poly Lines
  Set<Polyline> polyLines = {};
  List<LatLng> markerPositions = [];
  _drawPolyline() {
    if (markerPositions.length < 2) return;
    polyLines.clear();
    polyLines.add(
      Polyline(
          polylineId: PolylineId('route'),
          color: AppColors.black,
          width: 2,
          points: markerPositions,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          jointType: JointType.round),
    );
    notifyListeners();
  }

  /// Write Data On Selected Textfield
  TextEditingController? selectedController;
  setSelectedController(TextEditingController con) => selectedController = con;

  /// Update textfield value
  Future<void> updateSelectedTextField(String text,
      {bool isSource = true, bool isDestination = false, bool? fromAddress}) async {
    if (selectedController != null) {
      selectedController!.text = text;
      placesList.clear();
      notifyListeners();
    }
    if (fromAddress ?? false) {
      controllerList.last.text = text;
      notifyListeners();
    }
    final resp = await locationFromAddress(text);
    addLocationMarkers(LatLng(resp.first.latitude, resp.first.longitude), text,
        isSource: isSource, isDestination: isDestination);
  }

  ///Search Places
  List<Suggestions> placesList = [];
  searchLocation(String v) async {
    placesList.clear();
    try {
      final resp = await dio
          .post(Endpoints.places, queryParameters: {"input": v, "key": "AIzaSyCqOtn--DWaSee5PMjb1J1zkPe7gw5XMWQ"});
      final model = SuggestionsResponse.fromJson(resp.data);
      placesList = model.suggestions ?? [];
      notifyListeners();
    } catch (e) {}
  }

  /// Get Current Location
  LatLng? _currentLocation;
  bool _isLoading = false;

  LatLng? get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  Future<void> fetchCurrentLocation(LatLng? currentLocation) async {
    try {
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
        _currentLocation = currentLocation;
        if (_currentLocation != null) {
          await addLocationMarkers(_currentLocation!, address, isSource: true);
        }
        _isLoading = false;
        notifyListeners();
      } catch (e) {
        print('Error fetching location: $e');
      }
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
    nearByLocationList?.clear();
    markerPositions.clear();
    historyResponse = null;
    polyLines.clear();
    markers.clear();
  }
}
