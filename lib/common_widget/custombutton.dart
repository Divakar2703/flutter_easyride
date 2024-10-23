import 'package:flutter/material.dart';

class Customtbutton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final textColor;
  final VoidCallback? onPressed;
  final String? labletext;
  final font;
  final color;
  final Border;

  final fontFamily;
  const Customtbutton(
      {super.key,
      this.text,
      this.Border,
      this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.labletext,
      this.color,
      this.font,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
          decoration: BoxDecoration(
            // color: backgroundColor ?? Colors.yellow,
            borderRadius: BorderRadius.circular(15),
            color: color,
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
