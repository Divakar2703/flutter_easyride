import 'package:flutter/material.dart';
import '../model/trip_histry_details_model.dart';
import '../service/apiservice.dart';

class TripHistoryProvider with ChangeNotifier {
  final ApiServices _apiService = ApiServices();
  TripHistryDetailsModel? _tripData;
  bool _isLoading = false;

  TripHistryDetailsModel? get tripData => _tripData;
  bool get isLoading => _isLoading;

  Future<void> fetchTripHistory(String bookingId) async {
    _isLoading = true;
    notifyListeners();

    _tripData = await _apiService.fetchTripHistoryDetails(bookingId);

    _isLoading = false;
    notifyListeners();

    sortTrips();
  }

void sortTrips() {
  if (_tripData != null && _tripData!.trip != null) {
    _tripData!.trip!.sort((a, b) {
      if (a.rideStatus == 'Pending' && b.rideStatus == 'Completed') {
        return -1;
      } else if (a.rideStatus == 'Completed' && b.rideStatus == 'Pending') {
        return 1;
      }
      return 0;
    });
  }
}











}
