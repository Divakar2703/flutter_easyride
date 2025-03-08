import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/toast.dart';
import 'package:flutter_easy_ride/view/payments/provider/payment_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddMoneyScreen extends StatefulWidget {
  AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  Razorpay? _razorpay = Razorpay();

  Map<String, dynamic> bin2hex(String hexData) {
    List<int> bytes = [];
    for (int i = 0; i < hexData.length; i += 2) {
      bytes.add(int.parse(hexData.substring(i, i + 2), radix: 16));
    }

    String decodedString = utf8.decode(bytes);
    Map<String, dynamic> dataMap = jsonDecode(decodedString);
    return dataMap;
  }

  void handlePaymentFailure(PaymentFailureResponse paymentFailureResponse) {
    AppUtils.show(paymentFailureResponse.message.toString());
  }

  Future<void> handlePaymentSuccess(PaymentSuccessResponse success) async {
    AppUtils.show("Payment Successfully Done");
    final check = await context
        .read<PaymentProvider>()
        .verifyWalletPayment(orderId: success.orderId, paymentId: success.paymentId, signature: success.signature);
    if (check) {
      Navigator.pop(context);
    }
  }

  void handleWalletResponse(ExternalWalletResponse externalWalletResponse) {
    String chosenWallet = externalWalletResponse.walletName ?? "";
    switch (chosenWallet) {
      case 'paytm':
        break;
      case 'freecharge':
        break;
      default:
    }
  }

  void openRazorPay(
      int price, String productName, String productDescription, Map<String, dynamic> key, String orderId) {
    try {
      var options = {
        'key': key["key"],
        'amount': price,
        'order_id': orderId,
        'name': productName,
        'currency': "INR",
        'description': productDescription,
        'prefill': {'contact': '+91000000000', 'email': 'shum@yopmail.com'}
      };
      _razorpay?.open(options);
    } catch (error) {
      print("error ==>$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  color: AppColors.black.withOpacity(0.1),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
                  Text("Add Money", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox()
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    border: Border.all(color: AppColors.blue.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 14,
                        color: AppColors.black.withOpacity(0.1),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Money", style: TextStyle(color: AppColors.borderColor.withOpacity(0.7))),
                      Text("₹${context.read<PaymentProvider>().moneyAmount}", style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Prepaid Payment Method",
                        style: TextStyle(color: AppColors.borderColor.withOpacity(0.7)),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(height: 35, width: 45, AppImage.upi),
                          SizedBox(width: 15),
                          Text(
                            "UPI",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Consumer<PaymentProvider>(
                        builder: (context, v, child) => Container(
                          width: double.infinity,
                          child: Wrap(
                            runAlignment: WrapAlignment.start,
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(
                              v.paymentGateWayList.length,
                              (index) => GestureDetector(
                                  onTap: () {
                                    Map<String, dynamic>? paymentKey;
                                    if (v.paymentGateWayList[index].credentials != null &&
                                        v.paymentGateWayList[index].credentials != "")
                                      paymentKey = bin2hex(v.paymentGateWayList[index].credentials ?? "");
                                    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
                                    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
                                    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, handleWalletResponse);
                                    if (paymentKey != null) {
                                      openRazorPay(100, "Car", "Test", paymentKey,
                                          context.read<PaymentProvider>().addMoneyModel?.data?.orderId ?? "");
                                    }
                                  },
                                  child: Image.network(v.paymentGateWayList[index].icon ?? "",
                                      width: 45, height: 45, fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImage.cards),
                          SizedBox(width: 15),
                          Text(
                            "Cards",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(AppImage.visa, height: 40, width: 40),
                          Image.asset(AppImage.ruPay, height: 40, width: 40),
                          Image.asset(AppImage.mastercard, height: 40, width: 40),
                          Image.asset(AppImage.paypal, height: 40, width: 40),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImage.netBanking),
                        SizedBox(width: 15),
                        Text(
                          "Net Banking",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(right: 20, left: 20, bottom: 5),
      //   child: CommonButton(
      //     label: "Add Money Now",
      //     buttonBorderColor: AppColors.blue,
      //     buttonColor: AppColors.blue,
      //     labelColor: AppColors.white,
      //   ),
      // ),
    );
  }
}
