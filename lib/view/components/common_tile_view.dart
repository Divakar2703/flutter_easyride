import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';

class CommonTileView extends StatelessWidget {
  final String? time;
  final String? image;
  final String? title;
  final String? subTitle;
  final String? price;
  final bool? isSelected;
  final void Function()? onTap;
  const CommonTileView(
      {super.key, this.time, this.image, this.title, this.subTitle, this.price, this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: isSelected ?? false ? AppColors.yellow : Colors.transparent),
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
                  Image.network(image ?? "", height: 46, width: 66, fit: BoxFit.cover),
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
      ),
    );
  }
}
