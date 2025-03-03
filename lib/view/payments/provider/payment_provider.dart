import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/view/payments/models/payment_gateway_model.dart';
import 'package:flutter_easy_ride/view/payments/models/wallet_history_model.dart';
import 'package:flutter_easy_ride/view/payments/services/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  final paymentService = PaymentService();
  List<WalletHistoryDataModel> walletHistoryList = [];
  bool load = false;
  getWalletHistory() async {
    try {
      load = true;
      notifyListeners();
      final userId = await LocalStorage.getId();
      final resp = await paymentService.getWalletHistory(userId: userId);
      if (resp != null) {
        walletHistoryList = resp.data ?? [];
      }
      load = false;
      notifyListeners();
    } catch (e) {
      load = false;
      notifyListeners();
    }
  }

  String selectedPaymentMethod = "COD";

  changePaymentMode(String value) {
    selectedPaymentMethod = value;
    notifyListeners();
  }

  List<PaymentGatewayDataModel> paymentGateWayList = [];
  getPaymentGateways() async {
    try {
      final userId = await LocalStorage.getId();
      final resp = await paymentService.getPaymentGateways(userId: userId);
      if (resp != null) {
        paymentGateWayList = resp.data ?? [];
      }
      notifyListeners();
    } catch (e) {}
  }
}
