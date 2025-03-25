import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/view/car_selection/provider/car_selection_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  PaymentMethodBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Center(
              child: const Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<CarSelectionProvider>(
                builder: (context, v, child) => ListView.separated(
                  controller: controller,
                  itemCount: v.paymentTypeList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        v.changePaymentMode(v.paymentTypeList[index]);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                              width: 30, height: 30, fit: BoxFit.cover, v.paymentTypeList[index].icon ?? ""),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(v.paymentTypeList[index].name ?? "", style: const TextStyle(fontSize: 16))),
                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 18),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
