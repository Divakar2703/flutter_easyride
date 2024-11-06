import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final fontfamily;

  const CustomText(
    this.text, {
    Key? key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.fontfamily,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: color,
          fontFamily: 'Poppins'),
    );
  }
}
