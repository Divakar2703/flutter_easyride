import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/model/vehicle_data.dart';
import 'package:flutter_easy_ride/utils/constant.dart';

class CarSelectionProvider with ChangeNotifier {
  final dio = getIt.get<DioClient>();
  List<Vehicle> vehicleList = [];

  bool loading = false;

  getVehicles({double? pickup_lat, double? pickup_long, double? drop_lat, double? drop_long}) async {
    try {
      loading = true;
      notifyListeners();
      final resp = await dio.post(Endpoints.getVehicles,
          data: {"pickup_lat": pickup_lat, "pickup_long": pickup_long, "drop_lat": drop_lat, "drop_long": drop_long});
      final model = VehicleResponse.fromJson(resp.data);
      vehicleList = model.vehicle ?? [];
      loading = false;
      notifyListeners();
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      loading = false;
      notifyListeners();
      throw errorMessage;
    }
  }
}
