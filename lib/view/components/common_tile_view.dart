import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';

class CommonTileView extends StatelessWidget {
  final String? time;
  final String? image;
  final String? title;
  final String? subTitle;
  final String? price;
  const CommonTileView({super.key, this.time, this.image, this.title, this.subTitle, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 12,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Image.asset(image ?? "", height: 46, width: 66),
                Text(time ?? "", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title ?? "", style: TextStyle(fontSize: 18)),
                Text(subTitle ?? "", style: TextStyle(fontSize: 12, color: AppColors.borderColor.withOpacity(0.6))),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(price ?? "", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
