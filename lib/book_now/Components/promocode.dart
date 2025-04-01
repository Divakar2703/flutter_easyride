import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/common_widget/coupon_card_widget.dart';
import 'package:provider/provider.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

void openPromocodeBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow full-screen height
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false, // Enables flexible height adjustment when scrolled
        initialChildSize: 0.6, // Initial height as a percentage of screen height
        minChildSize: 0.4, // Minimum height
        maxChildSize: 1.0, // Maximum height (full screen)
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Scaffold(
                body: Consumer<CabBookProvider>(
                  builder: (BuildContext context, CabBookProvider value, Widget? child) {
                    return value.couponData!.coupon.isNotEmpty?SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Promo Codes",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black87,
                                  size: 20,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          for (var offer in value.couponData!.coupon)
                            CouponCard(
                              couponId: offer.couponId,
                              promocodeImg: offer.promocodeImg,
                              promoCode: offer.promoCode,
                              promoCodeDescription: offer.promoCodeDescription,
                              promoCodeDiscount: offer.promoCodeDiscount,
                              startDate: offer.startDate,
                              expiryDate: offer.expiryDate,
                              couponStatus: offer.couponStatus,
                              fare: offer.fare,
                              discount: offer.discount,
                              netFare: offer.netFare,
                            ),
                        ],
                      ),
                    ):Center(child: Text("No coupon available for this vehicle"));
                  },
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
