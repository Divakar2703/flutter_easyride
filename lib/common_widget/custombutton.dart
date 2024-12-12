import 'package:flutter/material.dart';

class Customtbutton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final textColor;
  final VoidCallback? onPressed;
  final String? labletext;
  final int? FontSize;
  final color;
  final Border;
  final double? width;
  final double? height;

  final fontFamily;
  const Customtbutton(
      {super.key,
      this.text,
      this.width = 300,
      this.height = 40,
      this.Border,
      this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.labletext,
      this.color,
      this.FontSize,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          width: width,
          height: height,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xff1937d7),
          ),
          child: Center(
            child: Text(
              labletext ?? text ?? '',
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
