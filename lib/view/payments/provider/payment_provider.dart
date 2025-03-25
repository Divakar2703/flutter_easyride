import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/date_formates.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/utils/toast.dart';
import 'package:flutter_easy_ride/view/booking/models/common_model.dart';
import 'package:flutter_easy_ride/view/payments/models/add_money_model.dart';
import 'package:flutter_easy_ride/view/payments/models/payment_gateway_model.dart';
import 'package:flutter_easy_ride/view/payments/models/wallet_history_model.dart';
import 'package:flutter_easy_ride/view/payments/services/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  final paymentService = PaymentService();
  List<HistoryList> walletHistoryList = [];
  String walletAmount = "";

  String? moneyAmount;

  selectFilter(int index) {
    typeList.forEach((e) => e.isSelected = false);
    typeList[index].isSelected = true;
    type = typeList[index].subTitle;
    notifyListeners();
  }

  changeAmount(String v) {
    moneyAmount = v;
    notifyListeners();
  }

  bool load = false;
  bool pullUp = true;
  int page = 1;
  String? type;

  final startCon = TextEditingController();
  final endCon = TextEditingController();

  List<CommonModel> typeList = [
    CommonModel(title: "Credit", subTitle: "credit", isSelected: false),
    CommonModel(title: "Debit", subTitle: "debit", isSelected: false),
  ];

  selectStartDate(BuildContext context, String? title) async {
    final date = await AppUtils.pickDate(context);
    if (date != null) {
      if (title?.toLowerCase().contains("start") ?? false) {
        startCon.text = DateFormats.formatDateYYYYMMDD(date);
      } else {
        endCon.text = DateFormats.formatDateYYYYMMDD(date);
      }
      notifyListeners();
    }
  }

  getWalletHistory() async {
    try {
      if (page == 1) {
        load = true;
        walletHistoryList.clear();
      }
      notifyListeners();
      final userId = await LocalStorage.getId();
      final resp = await paymentService.getWalletHistory(
          userId: userId, page: page, type: type, startDate: startCon.text, endDate: endCon.text);
      if (resp != null) {
        if (resp.data?.historyList != null && (resp.data?.historyList?.isNotEmpty ?? false)) {
          walletAmount = resp.data?.walletAmount ?? "0";
          walletHistoryList.addAll(resp.data?.historyList ?? []);
        } else {
          pullUp = false;
        }
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
  List<PaymentGatewayDataModel> paymentTypeList = [
    PaymentGatewayDataModel(name: "COD", value: "cod", icon: AppImage.wallet),
    PaymentGatewayDataModel(name: "Wallet", value: "wallet", icon: AppImage.wallet),
  ];
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
          getWalletHistory();
          return true;
        }
      }
      return false;
    } catch (e) {}
    return false;
  }
}
