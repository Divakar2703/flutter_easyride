import 'package:flutter/material.dart';

class PaymentFailedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      title: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red),
          SizedBox(width: 8.0),
          Text(
            'Payment Failed',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      content: Text(
        'Your payment could not be processed. Please try again later.',
        style: TextStyle(fontSize: 16.0),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Okay',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}