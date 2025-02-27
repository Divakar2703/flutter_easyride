import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/components/horizontal_image_text.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                blurRadius: 14,
                color: AppColors.black.withOpacity(0.1),
                offset: Offset(0, 2),
              )
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () => context.read<BottomBarProvider>().changePage(0),
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
                Text("Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox()
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Parth Kevadiya",
                          style: TextStyle(color: AppColors.borderColor, fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                      ),
                      SvgPicture.asset(AppImage.editSvg),
                    ],
                  ),
                  SizedBox(height: 20),
                  HorizontalImageText(image: AppImage.call, title: "9027573215"),
                  Divider(color: AppColors.black.withOpacity(0.1), height: 20),
                  HorizontalImageText(image: AppImage.email, title: "asadkhann2003@gmail.com"),
                  Divider(color: AppColors.black.withOpacity(0.1), height: 20),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.black.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Saved Address",
                          style: TextStyle(color: AppColors.borderColor, fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        HorizontalImageText(
                            image: AppImage.homeSvg,
                            titleColor: AppColors.borderColor,
                            title: "Home",
                            subTitle: "Murad Nagar, Ghaziabad"),
                        Divider(color: AppColors.black.withOpacity(0.1)),
                        HorizontalImageText(
                            image: AppImage.officeSvg,
                            titleColor: AppColors.borderColor,
                            title: "Office",
                            subTitle: "Sec 57, Gurugram, Haryana"),
                        Divider(color: AppColors.black.withOpacity(0.1)),
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.black.withOpacity(0.1)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppImage.pluse),
                                SizedBox(width: 3),
                                Text(
                                  "Add New",
                                  style: TextStyle(color: AppColors.black.withOpacity(0.7)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.black.withOpacity(0.1)),
                    ),
                    child: HorizontalImageText(
                      image: AppImage.setting,
                      title: "Account Setting",
                      titleColor: AppColors.borderColor,
                      titleFontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  HorizontalImageText(
                    title: "Logout",
                    viewIcon: true,
                    titleFontSize: 16,
                    image: AppImage.logout,
                    titleColor: AppColors.redColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void openCalendar(BuildContext context) {
  // Add your code to open the calendar here
  // For example, you can use showDialog to display a calendar dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Calendar'),
        content: Text('Calendar content goes here'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
