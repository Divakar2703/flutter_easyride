import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HorizontalImageText extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subTitle;
  final Color? titleColor;
  final double? titleFontSize;
  final bool? viewIcon;
  final bool? isAddress;
  final void Function()? onDeleteAddressTap;
  const HorizontalImageText({
    super.key,
    this.image,
    this.title,
    this.subTitle,
    this.titleColor,
    this.titleFontSize,
    this.viewIcon,
    this.isAddress,
    this.onDeleteAddressTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(image ?? ""),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title ?? "",
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? AppColors.borderColor.withOpacity(0.7),
                ),
              ),
              if (subTitle != null) ...[
                SizedBox(height: 5),
                Text(
                  subTitle ?? "",
                  maxLines: 2,
                  style: TextStyle(color: AppColors.borderColor.withOpacity(0.7), fontWeight: FontWeight.w500),
                )
              ]
            ],
          ),
        ),
        SizedBox(width: 10),
        viewIcon ?? false
            ? SizedBox.shrink()
            : isAddress ?? false
                ? GestureDetector(onTap: onDeleteAddressTap, child: SvgPicture.asset(AppImage.delete))
                : Icon(
                    size: 20,
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.borderColor.withOpacity(0.8),
                  )
      ],
    );
  }
}
