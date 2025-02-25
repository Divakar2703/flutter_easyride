import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/payment/dialog/payment_success_dialog.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../view/home/provider/dashboard_provider.dart';
import 'dialog/payment_failed_dialog.dart';
import 'model/cab_payment_model.dart';

class CabPaymentPage extends StatefulWidget {
  final String? orderId;
  final String? mid;
  final String? webCallbackUrl;
  final String? convCharge;
  final String? mainAmount;
  final String? txtAmount;
  final String? custId;

  CabPaymentPage({
    Key? key,
    this.orderId,
    this.mid,
    this.webCallbackUrl,
    this.convCharge,
    this.mainAmount,
    this.txtAmount,
    this.custId,
  }) : super(key: key);

  @override
  _CabPaymentPageState createState() => _CabPaymentPageState();
}

class _CabPaymentPageState extends State<CabPaymentPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            showPaymentFailedDialog(context);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('pay24Response_android')) {
              Uri uri = Uri.parse(request.url);
              String? infoValue = uri.queryParameters['info'];
              String decodedJson = decodeHex(infoValue ?? "");
              handleResponse(decodedJson, infoValue);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    loadPaymentPageData();
  }

  void loadPaymentPageData() {
    // URL for initiating the payment
    String paymentPageUrl = "https://pay-24.in/qw/main/index.php/onlinepayment/paynow";

    // Construct the POST data with the necessary parameters
    String postData =
        'ORDER_ID=${widget.orderId}&MID=15&WEB_CALLBACK_URL=https://bits-panindia.com/WL-CNT/main/index.php/homepage/pay24Response_android'
        '&CONV_CHARGE=${widget.convCharge}&MAIN_AMOUNT=1'
        '&TXN_AMOUNT=1&CUST_ID=15';
    print("re payment ==${postData}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Send data via POST to the WebView
      _controller.loadRequest(
        Uri.parse(paymentPageUrl),
        method: LoadRequestMethod.post,
        body: Uint8List.fromList(utf8.encode(postData)),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
    });
  }

  String decodeHex(String hex) {
    var bytes = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      var firstDigit = int.parse(hex[i], radix: 16);
      var secondDigit = int.parse(hex[i + 1], radix: 16);
      bytes.add(firstDigit * 16 + secondDigit);
    }
    return utf8.decode(bytes);
  }

  void handleResponse(String jsonString, String? infoValue) {
    try {
      final response = CabPaymentResponseModel.fromJson(json.decode(jsonString));
      Navigator.pop(context, {
        'orderId': response.orderId, // Changed from ORDER_ID to orderId
        'orderNo': response.orderNo,
        'txnAmount': response.txnAmount,
        'transId': response.custId,
        'status_code': response.resCode,
        'amount': response.mainAmount,
        'vpaid': response.vpaid,
        'status': response.status,
        'info': infoValue,
        'json': jsonString,
        'convCharge': response.convCharge,
        'custRefNum': response.custRefNo,
      });
      var req = {
        'orderId': response.orderId, // Changed from ORDER_ID to orderId
        'orderNo': response.orderNo,
        'txnAmount': response.txnAmount,
        'transId': response.custId,
        'status_code': response.resCode,
        'amount': response.mainAmount,
        'vpaid': response.vpaid,
        'status': response.status,
        'info': infoValue,
        'json': jsonString,
        'convCharge': response.convCharge,
        'custRefNum': response.custRefNo,
      };
      print("req==${req}");
      if (response.status == "SUCCESS") {
        transactionID = response.custId ?? "";
        showPaymentSuccessDialog(context, req);
        Provider.of<DashboardProvider>(context, listen: false)
            .sendNotification(response.orderNo ?? "", response.orderId ?? "", double.parse(response.txnAmount ?? "0"));

        setState(() {});
      } else {
        showPaymentFailedDialog(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid UPI Id')),
      );
    }
  }

  void showPaymentFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentFailedDialog();
      },
    );
  }

  void showPaymentSuccessDialog(BuildContext context, final Map<String, dynamic> req) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentSuccessDialog(
          req: req,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cab Payment'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
