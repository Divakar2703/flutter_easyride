import 'package:razorpay_flutter/razorpay_flutter.dart';


class RazorpayGatewayCommon {
  late Razorpay razorpay;


  void openRazorpay({
    required int amount,
    required String orderId,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    required Function(ExternalWalletResponse) onExternalWallet,
  }) {
    razorpay = Razorpay();

    var options = {
      'key': "rzp_test_rkEEf9GKtGHN9E",
      'amount': 1 * 100,
      'name': 'cab booking',
      'order_id': 'order_PIgUtacbxsSAdM',
      'image': "https://gotejaga.com/asset/img/gotelogo.png",
      'theme.color': "#8BC34A",
      'currency': "INR",
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '00000',
        'email': 'abc@gmail.com'
      },
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onFailure);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
    razorpay.open(options);
  }

}