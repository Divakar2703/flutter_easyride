import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';

class Indicator extends StatelessWidget {
  final Color? color;

  const Indicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(color: color ?? AppColors.yellowDark),
      ),
    );
  }
}
