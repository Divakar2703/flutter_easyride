import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/tripdetailsmodel.dart';
import 'package:flutter_easy_ride/service/trip_histrydetailservice.dart';

class TriphistrydetailsProvider with ChangeNotifier {
  List<Histrydetailsmodel> _tripList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Histrydetailsmodel> get tripList => _tripList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  final TripHistrydetailService _tripHistrydetailService =
      TripHistrydetailService();

  Future<void> fetchTripDetails() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _tripList = (await _tripHistrydetailService.fetchTripDetails())
          as List<Histrydetailsmodel>;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
