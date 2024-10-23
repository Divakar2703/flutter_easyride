import 'package:flutter/material.dart';
import '../service/trip_histryservice.dart';

class TripHistoryProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> _allTrips = [];
  List<dynamic> _filteredTrips = [];
  bool _isLoading = false;

  List<dynamic> get allTrips => _allTrips;
  List<dynamic> get filteredTrips => _filteredTrips;
  bool get isLoading => _isLoading;

  Future<void> fetchTripHistory(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _allTrips = await _apiService.getTripHistory(userId);
      _filteredTrips = _allTrips;
    } catch (error) {
  
      print("Error fetching trip history: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void filterTrips(String filter) {
    if (filter.isEmpty) {
      _filteredTrips = _allTrips; 
    } else {
      _filteredTrips = _allTrips.where((trip) {
        return trip['trip_name'].toLowerCase().contains(filter.toLowerCase()) ||
               trip['date'].toLowerCase().contains(filter.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}

  