import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/payment/razorpay/razorpay_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayGateway extends StatefulWidget {
  const RazorpayGateway({super.key});

  @override
  State<RazorpayGateway> createState() => _RazorpayGatewayState();
}

class _RazorpayGatewayState extends State<RazorpayGateway> {
  Razorpay? _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }
  void openPaymentPortal() async {

    var options = {
      'key': "rzp_live_kJZpBxT80OccTn",
      'amount': 1 * 100,
      'name': 'cab booking',
      'order_id': 1,
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
      'external': {
        'wallets': [
          'paytm',
        ],
      }
    };

    try {
      _razorpay?.open(options);
      print("Making payment");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay with Razorpay",style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){
             // openPaymentPortal();
              RazorpayGatewayCommon().openRazorpay(amount: 1, orderId: "1", onSuccess: handlePaymentSuccessResponse, onFailure: handlePaymentErrorResponse, onExternalWallet: handleExternalWalletSelected);
              // Razorpay razorpay = Razorpay();
              // var options = {
              //   'key': "rzp_test_8MolXcIIdqnwgO",
              //   'amount': 15800,
              //   'name': 'Rahul',
              //   'order_id': "order_P8qoPKGj0i8jmh",
              //   'image': "https://gotejaga.com/asset/img/gotelogo.png",
              //   'theme.color': "#8BC34A",
              //   'currency': "INR",
              //   'description': 'Burger',
              //   'retry': {'enabled': true, 'max_count': 1},
              //   'send_sms_hash': true,
              //   'prefill': {'contact': '7417314612', 'email': 'abcdjlj@razorpay.com'},
              // };
              // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
              // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
              // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
              // razorpay.open(options);

            },
            child: Text("Open Razorpay")
        ),
      ),
    );
  }
}