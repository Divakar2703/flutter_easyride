import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageTextWidget extends StatelessWidget {
  final String image;
  final String? subImage;
  final String? title;
  final void Function()? onTap;
  final MainAxisSize? mainAxisSize;
  final bool? isBorderView;
  final bool? isSelected;
  final bool? isLastIndex;
  const ImageTextWidget({
    super.key,
    required this.image,
    this.subImage,
    this.title,
    this.onTap,
    this.mainAxisSize,
    this.isBorderView,
    this.isSelected,
    this.isLastIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: isLastIndex ?? false ? 0 : 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: isBorderView ?? false
              ? Border.all(color: isSelected ?? false ? AppColors.yellowDark : Colors.transparent)
              : null,
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
            CachedNetworkImage(
              imageUrl: image,
              height: 53,
              width: 80,
              placeholder: (context, url) => Indicator(),
              errorWidget: (context, url, error) => Image.asset(image),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  height: 18,
                  width: 18,
                  imageUrl: subImage ?? "",
                  errorWidget: (context, url, error) => SvgPicture.asset(subImage ?? ""),
                ),
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
