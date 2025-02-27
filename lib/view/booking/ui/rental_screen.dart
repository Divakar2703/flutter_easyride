import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/components/common_location_textfield.dart';
import 'package:flutter_easy_ride/view/components/vertical_text.dart';
import 'package:provider/provider.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text("Select a package", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Image.asset(AppImage.rent, height: 20, width: 20)
          ],
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Consumer<BookNowProvider>(
            builder: (context, v, child) => Row(
              children: List.generate(
                v.kmList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: InkWell(
                    onTap: () => v.choosePackage(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                              color: v.kmList[index].isSelected ?? false
                                  ? AppColors.yellowDark
                                  : AppColors.borderColor.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(6)),
                      child: VerticalText(title: v.kmList[index].title, subTitle: v.kmList[index].subTitle),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
