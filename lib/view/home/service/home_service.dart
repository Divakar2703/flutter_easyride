import 'package:dio/dio.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/model/nearby_vehicle.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/home/models/booking_type_model.dart';

class HomeService {
  final dio = getIt.get<DioClient>();

  Future<NearByVehicle?> getLocationVehicles({double? lat, double? long}) async {
    try {
      final resp = await dio.post(Endpoints.nearbyVehicles, data: {"pickup_lat": lat, "pickup_long": long});
      if (resp.statusCode == 200) {
        return NearByVehicle.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<BookingTypeModel?> bookingType({double? lat, double? long}) async {
    try {
      final resp = await dio.get(Endpoints.getBookingType);
      if (resp?.statusCode == 200) {
        return BookingTypeModel.fromJson(resp?.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }
}
