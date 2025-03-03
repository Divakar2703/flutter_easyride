import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/model/vehicle_data.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class CarSelectionProvider with ChangeNotifier {
  final dio = getIt.get<DioClient>();
  List<VehicleList> vehicleList = [];

  bool loading = false;

  carSelection(int i) {
    vehicleList.forEach((e) => e..isSelected = false);
    vehicleList[i].isSelected = true;
    notifyListeners();
  }

  getVehicles(List<LatLng> latLang) async {
    List<Map<String, double>> list = [];
    try {
      loading = true;
      notifyListeners();
      latLang.forEach((e) => list.add({"lat": e.latitude, "long": e.longitude}));

      final userId = await LocalStorage.getId();
      final resp = await dio.post(Endpoints.getVehicles, data: {"waypoints": list, "user_id": userId});
      final model = VehicleResponse.fromJson(resp.data);
      vehicleList = model.data?.vehicleList ?? [];
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
