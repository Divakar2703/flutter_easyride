import 'package:dio/dio.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/model/location_suggetions.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/profile/models/address_model.dart';
import 'package:flutter_easy_ride/view/profile/models/booking_history_model.dart';
import 'package:flutter_easy_ride/view/profile/models/profile_model.dart';
import 'package:geocoding/geocoding.dart';

class ProfileService {
  final dio = getIt.get<DioClient>();

  Future<ProfileModel?> getProfile({int? userId}) async {
    try {
      final resp = await dio.post(Endpoints.getProfile, data: {"user_id": userId});
      if (resp.statusCode == 200) {
        return ProfileModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<ProfileModel?> updateProfile({String? name, String? email, int? phone, int? userId}) async {
    try {
      final resp = await dio
          .post(Endpoints.updateProfile, data: {"user_id": userId, "name": name, "email": email, "mobile": phone});
      if (resp.statusCode == 200) {
        return ProfileModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<AddressModel?> getSavedAddress({int? userId}) async {
    try {
      final resp = await dio.post(Endpoints.getSavedAddress, data: {"user_id": userId});
      if (resp.statusCode == 200) {
        return AddressModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<ProfileModel?> addAddress({String? type, String? address, int? userId, Location? latLng}) async {
    try {
      final resp = await dio.post(Endpoints.addAddress, data: {
        "user_id": userId,
        "type": type,
        "address": address,
        "latitude": latLng?.latitude,
        "longitude": latLng?.longitude
      });
      if (resp.statusCode == 200) {
        return ProfileModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<AddressModel?> deleteAddress({int? userId, int? id}) async {
    try {
      final resp = await dio.post(Endpoints.deleteAddress, data: {"user_id": userId, "id": id});
      if (resp.statusCode == 200) {
        return AddressModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<SuggestionsResponse?> searchLocation({String? v}) async {
    try {
      final resp = await dio
          .post(Endpoints.places, queryParameters: {"input": v, "key": "AIzaSyCqOtn--DWaSee5PMjb1J1zkPe7gw5XMWQ"});
      if (resp.statusCode == 200) {
        return SuggestionsResponse.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<BookingHistoryModel?> getBookingsHistory(
      {int? userId, int? page, String? search, String? startDate, String? endDate, String? type}) async {
    try {
      final response = await dio.post(Endpoints.getBookingHistory, data: {
        'user_id': userId,
        "search": search,
        "page": page,
        "start_date": startDate,
        "end_date": endDate,
        "booking_type": type
      });
      if (response.statusCode == 200) {
        return BookingHistoryModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }
}
