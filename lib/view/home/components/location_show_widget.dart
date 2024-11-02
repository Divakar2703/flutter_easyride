import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:flutter_easy_ride/utils/converter_function.dart';
import 'package:provider/provider.dart';

class LocationShowWidget extends StatelessWidget {
  const LocationShowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          margin:const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient:  LinearGradient(
                colors: [
                  ConverterFunction.parseColor(value.themeConfigg!.lightTheme.primaryColor),
                  //Color(0xff87A2FF),
                  Color(0xffC4D7FF),

                ], // Change these colors to your preferred gradient colors
                begin: Alignment.topLeft, // Optional: control the direction of the gradient
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40)
          ),
          child: const Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(width: 10,),
              Text(
                "Delhi mg rode,",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins', // Set Poppins as the default font
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white70,
                size: 16,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white70,
                size: 16,
              ),Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white70,
                size: 16,
              ),
            ],
          ),
        );

      },
    );
  }
}
