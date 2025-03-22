import 'package:dio/dio.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/dio_exceptions.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/payments/models/add_money_model.dart';
import 'package:flutter_easy_ride/view/payments/models/payment_gateway_model.dart';
import 'package:flutter_easy_ride/view/payments/models/wallet_history_model.dart';

class PaymentService {
  final dio = getIt.get<DioClient>();

  Future<WalletHistoryModel?> getWalletHistory(
      {int? userId, int? page, String? type, String? startDate, String? endDate}) async {
    try {
      final resp = await dio.post(Endpoints.getWalletHistory, data: {
        "user_id": userId,
        "page": page,
        "limit": 15,
        "transaction_type": type,
        "start_date": startDate,
        "end_date": endDate
      });
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

  Future<AddMoneyModel?> addMoneyToWallet({int? userId, String? amount}) async {
    try {
      final resp = await dio.post(Endpoints.addMoneyToWallet, data: {"user_id": userId, "amount": amount});
      if (resp.statusCode == 200) {
        return AddMoneyModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }

  Future<AddMoneyModel?> verifyWalletPayment({int? userId, String? orderId, paymentId, signature}) async {
    try {
      final resp = await dio.post(Endpoints.verifyWalletPayment,
          data: {"user_id": userId, "order_id": orderId, "payment_id": paymentId, "signature": signature});
      if (resp.statusCode == 200) {
        return AddMoneyModel.fromJson(resp.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
    return null;
  }
}
