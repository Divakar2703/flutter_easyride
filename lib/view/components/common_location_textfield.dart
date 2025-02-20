import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonLocationTextfield extends StatelessWidget {
  const CommonLocationTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerRight,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(AppImage.dot),
                            SizedBox(height: 1),
                            SvgPicture.asset(AppImage.dottedLine),
                            SizedBox(height: 1),
                            SvgPicture.asset(AppImage.location),
                          ],
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              CommonTextField(
                                hintText: "Source",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                              Divider(color: AppColors.black.withOpacity(0.1), height: 0),
                              CommonTextField(
                                hintText: "Destination",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
        Positioned(
          right: -5,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppImage.pluse),
                SizedBox(width: 5),
                Text("Add"),
              ],
            ),
          ),
        )
      ],
    );
  }
}
