import 'package:dio/dio.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/utils/constant.dart';

class HomeService {
  final dio = getIt.get<DioClient>();

  Future<void> authentication() async {
    try {
      final resp = dio.get(Endpoints.authApi);
      print("Successfully");
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
