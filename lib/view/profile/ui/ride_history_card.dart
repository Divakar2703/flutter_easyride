import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';
import 'package:flutter_easy_ride/view/components/common_text.dart';
import 'package:flutter_easy_ride/view/components/dotted_line.dart';
import 'package:flutter_easy_ride/view/profile/models/booking_history_model.dart';
import 'package:flutter_svg/svg.dart';

class HistoryCard extends StatelessWidget {
  final BookingHistoryList? bookingHistory;
  const HistoryCard({super.key, this.bookingHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white, boxShadow: [
        BoxShadow(offset: Offset(0, 2), blurRadius: 12, spreadRadius: 0, color: AppColors.black.withOpacity(0.08)),
      ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: AppColors.black.withOpacity(0.1),
                    )
                  ],
                ),
                child: Text(
                    (bookingHistory?.bookingType ?? "") == "book_now"
                        ? "Book Now"
                        : (bookingHistory?.bookingType ?? "") == "rental"
                            ? "Rental"
                            : "Pre-Booking",
                    style: AppText.poppins12),
              ),
              Text(bookingHistory?.bookingDate ?? "", style: AppText.poppins10500),
            ],
          ),
          SizedBox(height: 15),
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppImage.sourceSvg),
                  SizedBox(width: 10),
                  Expanded(child: Text(bookingHistory?.waypoints?.first.address ?? "")),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                child: DottedLine(),
              ),
              Row(
                children: [
                  SvgPicture.asset(AppImage.destinationSvg),
                  SizedBox(width: 8),
                  Expanded(child: Text(bookingHistory?.waypoints?.last.address ?? "")),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.black.withOpacity(.10)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: bookingHistory?.driverProfile ?? "",
                      placeholder: (context, url) => Indicator(),
                      errorWidget: (context, url, error) => Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${bookingHistory?.driverName ?? ""}", style: AppText.poppins12400),
                      SizedBox(height: 2),
                      Text("${bookingHistory?.makeName ?? ""} ${bookingHistory?.modelName ?? ""}",
                          style: AppText.poppins10400),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("₹${bookingHistory?.grandTotal ?? ""}", style: AppText.poppins182),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        SvgPicture.asset(bookingHistory?.paymentType == "wallet" ? AppImage.wallet : AppImage.cod,
                            height: 12, width: 12),
                        Text(" ${bookingHistory?.paymentType ?? ""}", style: AppText.poppins12400)
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
