import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';

class ImageTextWidget extends StatelessWidget {
  final String image;
  final String? subImage;
  final String? title;
  final void Function()? onTap;
  final MainAxisSize? mainAxisSize;
  const ImageTextWidget({
    super.key,
    required this.image,
    this.subImage,
    this.title,
    this.onTap,
    this.mainAxisSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              offset: Offset(0, 2),
              blurRadius: 12,
            )
          ],
        ),
        child: Column(
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          children: [
            Image.asset(height: 53, width: 80, image),
            SizedBox(height: 5),
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                subImage != null ? Image.asset(height: 18, width: 18, subImage ?? "") : SizedBox(),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
