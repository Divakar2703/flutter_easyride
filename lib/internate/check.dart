import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Connection Checker Example")),
        body: Column(
          children: [
            Lottie.asset('assets/images/connection1.json'),
            Lottie.asset('assets/images/Internated.json'),
            // Image.asset('assets/images/connection.gif'),



          ],
        ),
      ),
    );
  }
}
