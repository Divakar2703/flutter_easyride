// import 'package:flutter/material.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff3fdf6),
//       appBar: AppBar(
//         backgroundColor: Color(0xff1937d7),
//         title: Text('Payments',
//           style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Poppins', // Set Poppins as the default font
//               fontSize: 17,
//               color: Colors.white
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back,color: Colors.white,size: 21,),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             Padding(
//               padding: const EdgeInsets.only(left: 8, bottom: 10),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/d.webp',// Replace with your image asset path
//                     //color: Colors.grey.shade600,
//                     width: 30,
//                     height: 30,
//                   ),
//                   SizedBox(width: 18),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Easy Ride Wallet',
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Poppins', // Set Poppins as the default font
//                         ),
//                       ),
//                       Text(
//                         'Wallet balance. Rs.0.00',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black54,
//                           fontWeight: FontWeight.w400,
//                           fontFamily: 'Poppins', // Set Poppins as the default font
//                         ),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.grey.shade600,
//                       size: 16,
//                     ),
//                     onPressed: () {
//                       //   editNameBottomSheet(context);
//                     },
//                   )
//                 ],
//               ),
//             ),
//
//             Divider(
//               thickness: 1.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8, bottom: 10),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/cash.webp', // Replace with your image asset path
//                     //color: Colors.grey.shade600,
//                     width: 30,
//                     height: 30,
//                   ),
//                   SizedBox(width: 18),
//                   Text(
//                     'Cash',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Poppins', // Set Poppins as the default font
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.grey.shade600,
//                       size: 16,
//                     ),
//                     onPressed: () {
//                       //   editNameBottomSheet(context);
//                     },
//                   )
//                 ],
//               ),
//             ),
//
//
//
//             SizedBox(height: 15),
//             Row(
//               children: [
//                 Text(
//                   'Add Payment Methods',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Poppins', // Set Poppins as the default font
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(left: 8, bottom: 10),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/phonepay.png', // Replace with your image asset path
//                     //color: Colors.grey.shade600,
//                     width: 30,
//                     height: 30,
//                   ),
//                   SizedBox(width: 18),
//                   Text(
//                     'Add Phonepe Wallet',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Poppins', // Set Poppins as the default font
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.grey.shade600,
//                       size: 16,
//                     ),
//                     onPressed: () {
//                       //   editNameBottomSheet(context);
//                     },
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               thickness: 1.0,
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(left: 8, bottom: 10),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/apay.jpeg', // Replace with your image asset path
//                     //color: Colors.grey.shade600,
//                     width: 30,
//                     height: 30,
//                   ),
//                   SizedBox(width: 18),
//                   Text(
//                     'Add Amazon Pay',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Poppins', // Set Poppins as the default font
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.grey.shade600,
//                       size: 16,
//                     ),
//                     onPressed: () {
//                       //   editNameBottomSheet(context);
//                     },
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               thickness: 1.0,
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(left: 8, bottom: 10),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/paytm.jpeg', // Replace with your image asset path
//                     //color: Colors.grey.shade600,
//                     width: 30,
//                     height: 30,
//                   ),
//                   SizedBox(width: 18),
//                   Text(
//                     'Add Paytm Wallet',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Poppins', // Set Poppins as the default font
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.grey.shade600,
//                       size: 16,
//                     ),
//                     onPressed: () {
//                       //   editNameBottomSheet(context);
//                     },
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               thickness: 1.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8, bottom: 10),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/d.webp', // Replace with your image asset path
//                     //color: Colors.grey.shade600,
//                     width: 30,
//                     height: 30,
//                   ),
//                   SizedBox(width: 18),
//                   Text(
//                     'Add a Credit/Debit Card',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Poppins', // Set Poppins as the default font
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.grey.shade600,
//                       size: 16,
//                     ),
//                     onPressed: () {
//                       //   editNameBottomSheet(context);
//                     },
//                   )
//                 ],
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
