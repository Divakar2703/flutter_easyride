import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/nearby_vehicle.dart';
import 'package:flutter_easy_ride/service/api_helper.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/utils/toast.dart';
import 'package:flutter_easy_ride/view/home/service/home_service.dart';
import 'package:flutter_easy_ride/view/home/ui/home_screen.dart';
import 'package:flutter_easy_ride/view/notification/ui/notification_screen.dart';
import 'package:flutter_easy_ride/view/payments/wallet_screen.dart';
import 'package:flutter_easy_ride/view/profile/profile_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomBarProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List pages = [HomeScreen(), WalletScreen(), NotificationScreen(), ProfileScreen()];

  final homeService = HomeService();

  changePage(int index) {
    if (index != selectedIndex) selectedIndex = index;
    notifyListeners();
  }

  Set<Marker> markers = {};
  addLocationMarkers(LatLng l, {NearbyCab? e}) async {
    final markerId = MarkerId('marker_${markers.length}');
    final marker = Marker(
      markerId: markerId,
      position: l,
      icon: e != null
          ? await BitmapDescriptor.asset(
              ImageConfiguration(size: Size(45, 45)),
              e.type?.toLowerCase() == "car"
                  ? AppImage.carMap
                  : e.type?.toLowerCase() == "auto"
                      ? AppImage.autoMap
                      : e.type?.toLowerCase() == "bike"
                          ? AppImage.bikeMap
                          : "")
          : BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: e?.name ?? 'Current Location'),
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
      await getLocationVehicles();
      notifyListeners();
    } catch (e) {
      print('Error fetching location: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ///  Near By Vehicle
  bool loading = false;
  NearByVehicle? vehicleResponse;
  List<NearbyCab>? get vehicleList => vehicleResponse?.vehicle ?? [];

  Future<void> getLocationVehicles() async {
    loading = true;
    final String url = ApiHelper.nearbyVehicles;
    final params = {"pickup_lat": ALatitude, "pickup_long": ALongitude};

    try {
      final response = await NetworkUtility.sendPostRequest(url, params);
      if (response.statusCode == 200) {
        loading = false;
        final jsonData = jsonDecode(response.body);
        vehicleResponse = NearByVehicle.fromJson(jsonData);
        if (vehicleList?.isNotEmpty ?? false) {
          vehicleList?.forEach(
            (e) => addLocationMarkers(
              LatLng(double.parse(e.currLat ?? "0.0"), double.parse(e.currLong ?? "0.0")),
              e: e,
            ),
          );
        } else {
          AppUtils.show(vehicleResponse?.message ?? "");
        }
        notifyListeners();
      } else {
        loading = false;
        vehicleResponse = null;
      }
    } catch (e) {
      loading = false;
    }
  }
}
