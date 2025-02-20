import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        1000 ~/ 10,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : AppColors.black.withOpacity(0.2),
            height: 1,
          ),
        ),
      ),
    );
  }
}
