import 'package:flutter/material.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final Map<String, dynamic> req;
  const PaymentSuccessDialog({Key? key, required this.req}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 28),
          SizedBox(width: 10),
          Text('Payment Successful', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.greenAccent, thickness: 2),
            _buildInfoRow('Order ID', req['orderId']),
            _buildInfoRow('Order No', req['orderNo']),
            _buildInfoRow('Transaction Amount', req['txnAmount']),
            _buildInfoRow('Transaction ID', req['transId']),
            _buildInfoRow('Status Code', req['status_code']),
            _buildInfoRow('Amount', req['amount']),
            _buildInfoRow('VPaid', req['vpaid']),
            _buildInfoRow('Status', req['status']),
            _buildInfoRow('Convenience Charge', req['convCharge']),
            _buildInfoRow('Customer Ref No', req['custRefNum']),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Okay', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_right, color: Colors.green, size: 18),
          SizedBox(width: 5),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value ?? 'N/A'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}