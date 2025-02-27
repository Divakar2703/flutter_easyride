import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:flutter_easy_ride/view/payments/add_money_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  final bool? backVisible;
  const WalletScreen({super.key, this.backVisible});

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
                  InkWell(
                    onTap: () =>
                        backVisible ?? false ? Navigator.pop(context) : context.read<BottomBarProvider>().changePage(0),
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  ),
                  Text("Wallet", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox()
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    border: Border.all(color: AppColors.blue.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 14,
                        color: AppColors.black.withOpacity(0.1),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Available Bal:", style: TextStyle(color: AppColors.borderColor.withOpacity(0.7))),
                                Text("₹2290.0", style: TextStyle(fontSize: 24)),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(AppImage.pluse),
                                    SizedBox(width: 5),
                                    Text("Add Money"),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextField(
                        labelText: "Add Money",
                        keyBoardType: TextInputType.number,
                        labelStyle: TextStyle(color: AppColors.borderColor.withOpacity(0.8)),
                        suffix: Icon(Icons.close),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.borderColor.withOpacity(0.5)),
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                          alignment: WrapAlignment.start,
                          runSpacing: 10,
                          spacing: 10,
                          children: ["₹200", "₹500", "₹1000", "₹2000", "₹5000"]
                              .map(
                                (e) => Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(e),
                                ),
                              )
                              .toList())
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text("Wallet History")),
                      Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: backVisible ?? false ? 5 : 80),
        child: CommonButton(
          label: "Add Money Now",
          buttonBorderColor: AppColors.blue,
          buttonColor: AppColors.blue,
          labelColor: AppColors.white,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMoneyScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
