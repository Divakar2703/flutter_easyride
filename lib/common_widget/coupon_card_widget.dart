import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/service/api_helper.dart';

class CouponCard extends StatelessWidget {
  final String couponId;
  final String promocodeImg;
  final String promoCode;
  final String promoCodeDescription;
  final String promoCodeDiscount;
  final String startDate;
  final String expiryDate;
  final String couponStatus;
  final double fare;
  final double discount;
  final double netFare;

  const CouponCard({
    Key? key,
    required this.couponId,
    required this.promocodeImg,
    required this.promoCode,
    required this.promoCodeDescription,
    required this.promoCodeDiscount,
    required this.startDate,
    required this.expiryDate,
    required this.couponStatus,
    required this.fare,
    required this.discount,
    required this.netFare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.blue.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Promo Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ApiHelper.imageUrl+promocodeImg,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              // Promo Code Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      promoCodeDescription,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          // Promo Code and Discount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.code, color: Colors.blue),
                  SizedBox(width: 5),
                  Text(
                    promoCode,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              Text(
                promoCodeDiscount,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          // Fare and Net Fare
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fare: ₹$fare",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
              Text(
                "Net Fare: ₹$netFare",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          // Start Date and Expiry Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start: $startDate",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                "Expires: $expiryDate",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),

          // Apply Coupon Button
          GestureDetector(
            onTap: () {
              // Add your apply coupon logic here
              print("Coupon $promoCode applied");
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade600,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Apply Coupon",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
