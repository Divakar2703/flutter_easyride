import 'package:dio/dio.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/model/vehicle_data.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/car_selection/models/save_ride_model.dart';

class CarSelectionService {
  final dio = getIt.get<DioClient>();

  Future<VehicleResponse?> getVehicles(Map<String, Object> req) async {
    try {
      final response = await dio.post(Endpoints.getVehicles, data: req);
      if (response.statusCode == 200) {
        return VehicleResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<SaveRideModel?> bookNow(Map<String, Object?> req) async {
    try {
      final response = await dio.post(Endpoints.bookNow, data: req);
      if (response.statusCode == 200) {
        return SaveRideModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }
}
