import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_location_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BookNowScreen extends StatelessWidget {
  const BookNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonLocationTextfield(),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: context
                .read<BookNowProvider>()
                .addList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          e.image?.contains(".svg") ?? false
                              ? SvgPicture.asset(e.image ?? "")
                              : Image.asset(height: 14, width: 14, e.image ?? ""),
                          SizedBox(width: 5),
                          Text(e.title ?? ""),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SvgPicture.asset(AppImage.loc),
                title: Text("Sector 57 $index"),
                subtitle: Text("Sec 57, Gurugram, Haryana"),
              ),
              Divider(height: 0, color: AppColors.borderColor.withOpacity(0.2))
            ],
          ),
        ),
        CommonButton(label: "Confirm"),
      ],
    );
  }
}
