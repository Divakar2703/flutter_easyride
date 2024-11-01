import 'package:flutter/material.dart';
class RequestSuccess extends StatefulWidget {
  const RequestSuccess({super.key});

  @override
  State<RequestSuccess> createState() => _RequestSuccessState();
}

class _RequestSuccessState extends State<RequestSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request success'),
      ),
      body: Column(
        children: [
          Text('Request Successfull please  do code '),
        ],
      ),
    );
  }
}
