import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/provider/rental_provider.dart';
import 'package:flutter_easy_ride/view/car_selection/ui/car_selection_screen.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_location_textfield.dart';
import 'package:flutter_easy_ride/view/components/vertical_text.dart';
import 'package:provider/provider.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonLocationTextfield(),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Select a package", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Image.asset(AppImage.rent, height: 20, width: 20)
          ],
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: context
                .read<RentalProvider>()
                .kmList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.borderColor.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(6)),
                      child: VerticalText(title: e.title, subTitle: e.subTitle),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 15),
        CommonButton(
          label: "Confirm",
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CarSelectionScreen(),
            ),
          ),
        )
      ],
    );
  }
}
