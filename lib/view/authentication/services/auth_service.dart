import 'package:dio/dio.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/toast.dart';
import 'package:flutter_easy_ride/view/authentication/models/login_response.dart';

class AuthService {
  final dio = getIt.get<DioClient>();

  Future<int> registerCabUser({String? email, String? name, String? phone, String? fToken, String? referralId}) async {
    try {
      final response = await dio.post(Endpoints.registerUser, data: {
        "email": email ?? "",
        "name": name ?? "",
        "phone": phone ?? "",
        "type": "cab",
        "f_token_app": fToken ?? "",
        "referId": referralId ?? ""
      });
      if (response.statusCode == 200) {
        return response.statusCode ?? 0;
      }
      return response.statusCode ?? 0;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<int> sendOtp({String? phone}) async {
    try {
      final resp = await dio.post(Endpoints.sendOtp, data: {"phone": phone});
      if (resp.statusCode == 200) {
        AppUtils.show(resp.data["message"]);
        return resp.statusCode ?? 0;
      }
      return resp.statusCode ?? 0;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<LoginModel?> verifyOtp({String? phone, String? otp}) async {
    try {
      final resp = await dio.post(Endpoints.verifyOtp, data: {"phone": phone ?? "", "otp": otp ?? ""});

      final loginModel = LoginModel.fromJson(resp.data);
      if (loginModel.statusCode == 200 && loginModel.status == "success") {
        AppUtils.show(loginModel.message ?? "Something wrong");
        return loginModel;
      } else {
        AppUtils.show(loginModel.message ?? "Something wrong");
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }
}
