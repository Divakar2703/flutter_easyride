import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_location_textfield.dart';
import 'package:flutter_easy_ride/view/components/custom_time_picker.dart';
import 'package:flutter_easy_ride/view/components/horizontal_calender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PreBookingScreen extends StatelessWidget {
  const PreBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(context.watch<BookNowProvider>().controllerList.first.text);
    print(context.watch<BookNowProvider>().controllerList.last.text);
    return Column(
      children: [
        if (context.watch<BookNowProvider>().controllerList.first.text.isEmpty ||
            context.watch<BookNowProvider>().controllerList.last.text.isEmpty) ...[
          CommonLocationTextfield(),
          SizedBox(height: 20),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Schedule a Ride", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SvgPicture.asset(AppImage.calender)
          ],
        ),
        SizedBox(height: 10),
        HorizontalCalendar(),
        SizedBox(height: 15),
        CustomTimePicker(),
        SizedBox(height: 10),
        CommonButton(label: "Confirm")
      ],
    );
  }
}
