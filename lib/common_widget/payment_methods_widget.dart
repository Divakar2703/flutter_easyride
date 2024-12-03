import 'package:flutter/material.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  final Function(String) onPaymentSelected;

   PaymentMethodBottomSheet({Key? key, required this.onPaymentSelected}) : super(key: key);

  final List<Map<String, dynamic>> banks = [
    {'name': 'Online', 'image': 'assets/images/gpay.jpg'},
    {'name': 'Razorpay', 'image': 'assets/images/paytem.png'},
    {'name': 'PhonePay', 'image': 'assets/images/phonepay.png'},
    {'name': 'COD', 'image': 'assets/images/rojapay.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  controller: controller,
                  itemCount: banks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onPaymentSelected(banks[index]['name']);
                      //  Navigator.pop(context); // Close the bottom sheet after selection
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            // Image for the payment method
                            Image.asset(
                              banks[index]['image'],
                              width: 30, // Adjust the size of the image as needed
                              height: 30,
                            ),
                            const SizedBox(width: 10), // Space between image and text
                            // Payment method name
                            Text(
                              banks[index]['name'],
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Spacer(), // Push the arrow icon to the end
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
