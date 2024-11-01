import 'package:flutter/material.dart';
class CustomSnackbar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final double height;
  final double widthFactor;
  final TextStyle textStyle;
  final int durationInSeconds;

  const CustomSnackbar({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.blue,
    this.height = 70,
    this.widthFactor = 0.9,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 16),
    this.durationInSeconds = 3,
  }) : super(key: key);


  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: durationInSeconds),
      content: Container(
        height: height,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (1 - widthFactor) / 2,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            message,
            style: textStyle,
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink(); 
  }
}
