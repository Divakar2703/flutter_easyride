import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonButton extends StatelessWidget {
  final String? label;
  final Color? buttonColor;
  final double? height;
  final void Function()? onPressed;
  final double? labelSize;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final double? buttonRadius;
  final String? labelLogo;
  final Color? buttonBorderColor;
  final double? width;
  final Color? buttonColorGrade;
  final String? img;
  final Color? imgColor;
  final bool? textShadow;
  final double? horizontalPadding;
  final bool? load;

  const CommonButton({
    this.label,
    this.buttonColor,
    this.height,
    this.width,
    this.onPressed,
    this.labelSize,
    this.labelColor,
    this.labelWeight,
    this.buttonRadius,
    this.labelLogo,
    this.buttonBorderColor,
    this.buttonColorGrade,
    this.img,
    this.imgColor,
    this.textShadow,
    this.horizontalPadding,
    this.load,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => buttonColor ?? AppColors.black),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              side: BorderSide(color: buttonBorderColor ?? AppColors.black),
              borderRadius: BorderRadius.all(Radius.circular(buttonRadius ?? 12)),
            ),
          ),
          padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(horizontal: horizontalPadding ?? 20, vertical: 15),
          ),
          elevation: MaterialStateProperty.resolveWith((states) => 0.0),
        ),
        child: load ?? false
            ? SizedBox(width: 25, height: 25, child: CircularProgressIndicator(color: AppColors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  img != null ? SvgPicture.asset(img ?? "", fit: BoxFit.contain, color: imgColor) : const SizedBox(),
                  img != null ? const SizedBox(width: 10) : const SizedBox(),
                  Expanded(
                    child: Text(
                      label ?? "",
                      style: TextStyle(
                          fontSize: labelSize ?? 16,
                          color: labelColor ?? AppColors.yellow,
                          fontWeight: labelWeight ?? FontWeight.w600,
                          overflow: TextOverflow.ellipsis),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
