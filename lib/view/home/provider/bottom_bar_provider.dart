import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/nearby_vehicle.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/toast.dart';
import 'package:flutter_easy_ride/view/home/models/booking_type_model.dart';
import 'package:flutter_easy_ride/view/home/service/home_service.dart';
import 'package:flutter_easy_ride/view/home/ui/home_screen.dart';
import 'package:flutter_easy_ride/view/notification/ui/notification_screen.dart';
import 'package:flutter_easy_ride/view/payments/ui/wallet_screen.dart';
import 'package:flutter_easy_ride/view/profile/ui/profile_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomBarProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List pages = [
    HomeScreen(),
    WalletScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  final homeService = HomeService();

  changePage(int index) {
    if (index != selectedIndex) selectedIndex = index;
    notifyListeners();
  }

  int bookingTypeIndex = 0;

  changeBooking(int index) {
    bookingTypeIndex = index;
    notifyListeners();
  }

  Set<Marker> markers = {};
  addLocationMarkers(LatLng l, {NearbyCab? e, bool? isClear}) async {
    if (isClear ?? false) {
      markers.clear();
    }
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
  LatLng? currentLocation;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  onCameraIdle() async {
    if (currentLocation != null) {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentLocation?.latitude ?? 0.0, currentLocation?.longitude ?? 0.0);

      homeSearchCon.text =
          '${placeMarks[0].thoroughfare}, ${placeMarks[0].subLocality}, ${placeMarks[0].locality}, ${placeMarks[0].administrativeArea}, ${placeMarks[0].postalCode}';
      if (currentLocation != null) {
        await getLocationVehicles();
      }
    }
  }

  changeMapPosition(CameraPosition p) async {
    currentLocation = p.target;
    addLocationMarkers(currentLocation!, isClear: true);
  }

  Future<void> fetchCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
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

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

      // Update the current location
      currentLocation = LatLng(position.latitude, position.longitude);
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      homeSearchCon.text =
          '${placeMarks[0].thoroughfare}, ${placeMarks[0].subLocality}, ${placeMarks[0].locality}, ${placeMarks[0].administrativeArea}, ${placeMarks[0].postalCode}';
      if (currentLocation != null) {
        addLocationMarkers(currentLocation!);
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
  List<NearbyCab> vehicleList = [];

  Future<void> getLocationVehicles() async {
    loading = true;
    try {
      final resp = await homeService.getLocationVehicles(
          lat: currentLocation?.latitude, long: currentLocation?.longitude);
      if (resp != null) {
        loading = false;
        vehicleList = resp.vehicle ?? [];
        if (vehicleList.isNotEmpty) {
          vehicleList.forEach(
            (e) => addLocationMarkers(
              LatLng(double.parse(e.currLat ?? "0.0"),
                  double.parse(e.currLong ?? "0.0")),
              e: e,
            ),
          );
        } else {
          AppUtils.show(resp.message ?? "");
        }
        notifyListeners();
      } else {
        loading = false;
      }
    } catch (e) {
      loading = false;
    }
  }

  bool loadBooking = false;
  List<BookingTypeDataModel> bookingTypeList = [];
  Future<void> bookingType() async {
    loadBooking = true;
    try {
      final resp = await homeService.bookingType();
      if (resp != null) {
        bookingTypeList = resp.data ?? [];
        loadBooking = false;
      } else {
        loadBooking = false;
      }
      notifyListeners();
    } catch (e) {
      loadBooking = false;
      notifyListeners();
    }
  }
}
