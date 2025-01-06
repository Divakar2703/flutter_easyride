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
      this.FontSize,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:Colors.blue, // Background color of the circle

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
    );
  }
}
