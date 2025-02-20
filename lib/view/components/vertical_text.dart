import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? fontSize;
  final FontWeight? fontWeight;

  const VerticalText({
    super.key,
    this.title,
    this.subTitle,
    this.crossAxisAlignment,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Text(
          title ?? "",
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
        Text(
          subTitle ?? "",
          style: TextStyle(),
        ),
      ],
    );
  }
}
