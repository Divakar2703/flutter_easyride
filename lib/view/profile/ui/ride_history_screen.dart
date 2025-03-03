import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/components/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  InkWell(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
                  Text("History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox()
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CommonTextField(
                    height: 38,
                    contentPadding: EdgeInsets.all(5),
                    cursorHeight: 18,
                    suffix: SvgPicture.asset(AppImage.search),
                  ),
                ),
                SizedBox(width: 10),
                SvgPicture.asset(AppImage.filter),
                SizedBox(width: 10),
                SvgPicture.asset(AppImage.sort),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 1,
              padding: EdgeInsets.all(15),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: Offset(0, 2),
                      color: AppColors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    spreadRadius: 0,
                                    offset: Offset(0, 2),
                                    color: AppColors.black.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Text("Book Now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text("Today (03:42 PM)", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(AppImage.sourceSvg),
                        SizedBox(width: 10),
                        Expanded(child: Text("Muradnagr, Ghaziabad", style: TextStyle(fontSize: 16))),
                      ],
                    ),
                    DottedLine(),
                    Row(
                      children: [
                        SvgPicture.asset(AppImage.destinationSvg),
                        SizedBox(width: 10),
                        Expanded(child: Text("Sec 57, Gurugram, Haryana", style: TextStyle(fontSize: 16))),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.black.withOpacity(0.1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(radius: 17.5),
                          SizedBox(width: 15),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Rahul Sharma", style: TextStyle(fontSize: 12)),
                                Text("Rahul Sharma", style: TextStyle(fontSize: 10))
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₹290",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.green),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(AppImage.wallet, height: 12, width: 12),
                                    SizedBox(width: 5),
                                    Text(
                                      "Wallet",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.black.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Re-book Ride",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.black.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
