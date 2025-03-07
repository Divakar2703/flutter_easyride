import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/view/payments/models/add_money_model.dart';
import 'package:flutter_easy_ride/view/payments/models/payment_gateway_model.dart';
import 'package:flutter_easy_ride/view/payments/models/wallet_history_model.dart';
import 'package:flutter_easy_ride/view/payments/services/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  final paymentService = PaymentService();
  List<HistoryList> walletHistoryList = [];
  String walletAmount = "";

  String? moneyAmount;

  changeAmount(String v) {
    moneyAmount = v;
    notifyListeners();
  }

  bool load = false;
  getWalletHistory() async {
    try {
      load = true;
      notifyListeners();
      final userId = await LocalStorage.getId();
      final resp = await paymentService.getWalletHistory(userId: userId);
      if (resp != null) {
        walletAmount = resp.data?.walletAmount ?? "0";
        walletHistoryList = resp.data?.historyList ?? [];
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

  bool addMoneyLoad = false;
  AddMoneyModel? addMoneyModel;
  Future<bool> addMoneyToWallet(String amount) async {
    try {
      addMoneyLoad = true;
      notifyListeners();
      final userId = await LocalStorage.getId();
      final resp = await paymentService.addMoneyToWallet(userId: userId, amount: amount);
      if (resp != null) {
        if (resp.status == "success") {
          addMoneyModel = resp;
          addMoneyLoad = false;
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      addMoneyLoad = false;
      notifyListeners();
    }
    return false;
  }

  Future<bool> verifyWalletPayment({String? orderId, paymentId, signature}) async {
    try {
      final userId = await LocalStorage.getId();

      final resp = await paymentService.verifyWalletPayment(
          userId: userId, orderId: orderId, paymentId: paymentId, signature: signature);
      if (resp != null) {
        if (resp.status == "success") {
          addMoneyModel = resp;
          return true;
        }
      }
    } catch (e) {}
    return false;
  }
}
