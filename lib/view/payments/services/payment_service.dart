import 'package:dio/dio.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/payments/models/payment_gateway_model.dart';
import 'package:flutter_easy_ride/view/payments/models/wallet_history_model.dart';

class PaymentService {
  final dio = getIt.get<DioClient>();

  Future<WalletHistoryModel?> getWalletHistory({int? userId}) async {
    try {
      final resp = await dio.post(Endpoints.getWalletHistory, data: {"user_id": userId});
      if (resp.statusCode == 200) {
        return WalletHistoryModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<PaymentGatewayModel?> getPaymentGateways({int? userId}) async {
    try {
      final resp = await dio.post(Endpoints.getPaymentGateways, data: {"user_id": userId});
      if (resp.statusCode == 200) {
        return PaymentGatewayModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }
}
