import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/drive_looking_provider.dart';  

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Provider.of<ProgressBarState>(context).currentStep >= 1
                  ? Colors.blue
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
       
        Expanded(
          child: Container(
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Provider.of<ProgressBarState>(context).currentStep >= 2
                  ? Colors.blue
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
       
        Expanded(
          child: Container(
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Provider.of<ProgressBarState>(context).currentStep >= 3
                  ? Colors.blue
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      
        Expanded(
          child: Container(
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Provider.of<ProgressBarState>(context).currentStep >= 4
                  ? Colors.blue
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
