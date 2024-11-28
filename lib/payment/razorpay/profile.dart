// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easy_ride/payment/razorpay/phonepay.dart';
// import 'package:flutter_easy_ride/payment/razorpay/razorpay_screen.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ProfileNewScreen extends StatefulWidget {
//
//   const ProfileNewScreen({super.key});
//
//   @override
//   State<ProfileNewScreen> createState() => _ProfileNewScreenState();
// }
//
// class _ProfileNewScreenState extends State<ProfileNewScreen> {
//   late RazorpayGatewayCommon razorpayGateway;
//
//   final List<Map<String, dynamic>> items = [
//     {'icon': Icons.summarize, 'text': 'Wallet Summary', 'route': ''},
//     {'icon': Icons.share, 'text': 'Share the app', 'route': ''},
//     {'icon': Icons.star_rate, 'text': 'Rate Us', 'route': ''},
//     {'icon': CupertinoIcons.exclamationmark, 'text': 'About Us', 'route': ''},
//     {'icon': Icons.policy_outlined, 'text': 'Terms & Conditions', 'route': 'common_webview'},
//     {'icon': Icons.policy_outlined, 'text': 'Privacy Policy', 'route': 'common_webview'},
//     {'icon': Icons.policy_outlined, 'text': 'Refund Policy', 'route': 'common_webview'},
//     {'icon': Icons.policy_outlined, 'text': 'Shipping Policy', 'route': 'common_webview'},
//     {'icon': Icons.feedback_outlined, 'text': 'Feedback', 'route': ''},
//     {'icon': Icons.shopping_bag_outlined, 'text': 'Orders', 'route': ''},
//     {'icon': Icons.logout_outlined, 'text': 'Logout', 'route': ''},
//     {'icon': Icons.payment_outlined, 'text': 'Go to Payments', 'route': ''},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     razorpayGateway = RazorpayGatewayCommon();
//   }
//
//
//   void initiatePayment() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PhonePeGatewayWebView(
//           orderId: "1",
//           txnAmount: 1,
//         ),
//       ),
//     );
//
//     print("payResult>> $result");
//
//     if (result != null) {
//       // Handle the result here
//       setState(() {
//         if (result['success']) {
//
//           num onlineAmt = result['amount'] / 100;
//
//           Fluttertoast.showToast(msg: "$onlineAmt Rs Payment Successful");
//
//           print('values of amount:-  $onlineAmt');
//
//         } else {
//           print("Payment Failed: ${result['message']}");
//           Fluttertoast.showToast(msg: "Payment Failed: ${result['message']}");
//         }
//       }
//       );
//     }else{
//       Fluttertoast.showToast(msg:"Error in getting payment result");
//     }
//
//   }
//
//   void showAlertDialog(BuildContext context, String title, String message){
//     // set up the buttons
//     Widget continueButton = ElevatedButton(
//       child: const Text("Continue"),
//       onPressed:  () {},
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(message),
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 5.0,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             padding: const EdgeInsets.only(left: 25),
//             child: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         title: const Text(
//            "Profile",
//           style: TextStyle(fontWeight: FontWeight.w600,
//             fontSize: 19,),
//
//         ),
//       ),
//       body: ListView(padding: const EdgeInsets.all(16), children: [
//         const Text(
//           "My account",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         // GestureDetector(
//         //     onTap: (){
//         //       // Navigator.push(
//         //       //   context,
//         //       //   MaterialPageRoute(builder: (context) => EditProfile()),
//         //       // );
//         //     },
//         //     child: UserProfileCard()
//         // ),
//         const SizedBox(
//           height: 15,
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         ListView.separated(
//
//             separatorBuilder: (context, index) => Divider(
//               color: Colors.grey.shade400,
//               thickness: 0.5,
//               indent: 0,
//               endIndent: 0,
//             ),
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(top: 8),
//                 child: GestureDetector(
//                   onTap: () {
//                     switch(index){
//                       case 3:navigateToCommonWebView(AppUrl.aboutUsUrl,"About Us");
//                       case 4:navigateToCommonWebView(AppUrl.termsConditionsUrl,"Terms & Conditions");
//                       case 5:navigateToCommonWebView(AppUrl.privacyPolicyUrl,"Privacy Policy");
//                       case 6:navigateToCommonWebView(AppUrl.refundPolicyUrl,"Refund Policy");
//                       case 7:navigateToCommonWebView(AppUrl.shippingPolicyUrl,"Shipping Policy");
//                     // case 8: Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => OrderListing()),
//                     // );
//                     // case 8:openProductDetailsBottomSheet(context);
//                       case 9: Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => OrderListing()),
//                       );
//                     // case 11: initiatePayment();
//                       case 11: razorpayGateway.openRazorpay(
//                           amount: 1,
//                           orderId: "order_P8s27FeT96ZmT5",
//                           onSuccess: (PaymentSuccessResponse response){
//                             showAlertDialog(context, "Payment Successful", "Pay Amount: ${response.orderId} \nPayment ID: ${response.paymentId}");
//                           },
//                           onFailure: (PaymentFailureResponse response){
//                             showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
//                           },
//                           onExternalWallet: (ExternalWalletResponse response){
//                             showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
//                           }
//                       );
//                     }
//                   },
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor:
//                         Colors.green.shade50, // Set the background color
//                         radius: 20, // Set the radius
//                         child: Icon(
//                           items[index]['icon'],
//                           color: Colors.green.shade400,
//                           size: 24, // Set the icon color
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 12,
//                       ),
//                       Text(
//                         items[index]['text'],
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.blueGrey.shade900),
//                       ),
//                       const Spacer(),
//                       const Icon(
//                         Icons.arrow_forward_ios_outlined,
//                         color: Colors.grey,
//                         size: 14,
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       ]),
//     );
//   }
//
//   void navigateToCommonWebView(String url,String pageName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CommonWebview(url: url,pageName: pageName)),
//     );
//   }
//
// }