// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'dart:io';
//
// class PhonePeGatewayWebView extends StatefulWidget {
//   final String orderId;
//   final int txnAmount;
//
//   const PhonePeGatewayWebView({super.key, required this.orderId, required this.txnAmount});
//
//   @override
//   _PhonePeGatewayWebViewState createState() => _PhonePeGatewayWebViewState();
// }
//
// class _PhonePeGatewayWebViewState extends State<PhonePeGatewayWebView> {
//   late final WebViewController _controller;
//   String postData = '';
//   String transId = '';
//   String custId = "";
//
//   @override
//   void initState() {
//     super.initState();
//
//     transId = generateTransactionId();
//
//     // Creating platform-specific WebViewController
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is AndroidWebViewPlatform) {
//       params = const PlatformWebViewControllerCreationParams();
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }
//
//
//     _controller = WebViewController.fromPlatformCreationParams(params)
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {},
//
//           onPageStarted: (String url) {},
//
//           onPageFinished: (String url) {
//             print('Page>>>> finished loading: $url');
//
//             // Check if the URL changes to the desired callback URL
//             if (url.contains('paymentInfo')) {
//
//               // Extract the 'info' parameter.
//               final uri = Uri.parse(url);
//               final info = uri.queryParameters['info'];
//
//               print('Page>>>>: $info');
//
//               if (info != null) {
//                 final decodedInfo = _decodeHex(info);
//                 print('Decoded info: $decodedInfo');
//
//                 handlePaymentInfo(decodedInfo);
//
//               }
//             }
//
//           },
//           onWebResourceError: (WebResourceError error) {
//             print('Page>>>> Failed to load page: ${error.description}');
//           },
//         ),
//       );
//
//     if (_controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (_controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//
//     _loadPaymentPage();
//
//   }
//
//   String generateTransactionId() {
//     const prefix = 'MT';
//     final random = Random();
//     final digits = List.generate(16, (_) => random.nextInt(10)).join();
//     return '$prefix$digits';
//   }
//
//   void _loadPaymentPage() async {
//
//     postData = 'order_id=${widget.orderId}&trans_id=$transId&user_id=$custId&TXN_AMOUNT=${widget.txnAmount}&callback=&payment_mode="UPI"&used_for=app';
//     print("Page>>>> $postData");
//     const paymentPageUrl = 'https://gotejaga.com/Phonepe/pay';
//
//     // Setting user agent for desktop mode
//     String userAgent;
//     if (Platform.isAndroid) {
//       userAgent =
//       "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36";
//     } else {
//       // For iOS or other platforms if needed
//       userAgent =
//       "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36";
//     }
//
//     _controller.setUserAgent(userAgent);
//
//     _controller.loadRequest(
//       Uri.parse(paymentPageUrl),
//       method: LoadRequestMethod.post,
//       body: Uint8List.fromList(postData.codeUnits),
//     );
//   }
//
//   String _decodeHex(String hex) {
//     var result = List.generate(hex.length ~/ 2, (i) {
//       int firstDigit = int.parse(hex[i * 2], radix: 16);
//       int secondDigit = int.parse(hex[i * 2 + 1], radix: 16);
//       return (firstDigit << 4) + secondDigit;
//     });
//     return String.fromCharCodes(result);
//   }
//
//   void handlePaymentInfo(String jsonString) {
//     try {
//       // Decode the JSON string into a Map
//       final Map<String, dynamic> response = jsonDecode(jsonString);
//
//       // Accessing the nested fields
//       final paymentInfo = response['payment'];
//       final success = paymentInfo['success'];
//       final code = paymentInfo['code'];
//       final message = paymentInfo['message'];
//       final transactionId = paymentInfo['data']['transactionId'];
//       final amount = paymentInfo['data']['amount'];
//       final state = paymentInfo['data']['state'];
//
//       // Prepare data to send back to the previous page
//       final paymentResult = {
//         'success': success,
//         'transactionId': transactionId,
//         'amount': amount,
//         'state': state,
//         'message': message,
//         'code': code,
//       };
//
//       // Pop the current page and pass the result back
//       Navigator.pop(context, paymentResult);
//
//     } catch (e) {
//       print('Failed to parse payment info: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Payment')),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
//
// }