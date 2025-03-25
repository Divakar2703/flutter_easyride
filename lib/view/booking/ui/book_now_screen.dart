import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/components/common_location_textfield.dart';
import 'package:flutter_easy_ride/view/profile/provider/profile_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
          child: Consumer<ProfileProvider>(
            builder: (context, v, child) => Row(
              children: v.addressList
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<BookNowProvider>().updateSelectedTextField(e.address ?? "",
                              isSource: false, isDestination: true, fromAddress: true);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.black.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                  e.type?.toLowerCase() == "home"
                                      ? AppImage.homeSvg
                                      : e.type?.toLowerCase() == "office"
                                          ? AppImage.officeSvg
                                          : AppImage.location,
                                  height: 20,
                                  width: 20),
                              SizedBox(width: 5),
                              Text(e.type ?? ""),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Consumer<BookNowProvider>(
          builder: (context, v, child) => v.loadDropLocation
              ? Shimmer.fromColors(
                  baseColor: Colors.red.shade300,
                  highlightColor: Colors.blueAccent.shade100,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ListTile(
                      leading: Container(height: 25, width: 25),
                      title: Text(""),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: v.placesList.length,
                  itemBuilder: (context, index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(AppImage.loc),
                        title: Text(v.placesList[index].placePrediction?.text?.text ?? ""),
                        onTap: () {
                          String selectedText = v.placesList[index].placePrediction?.text?.text ?? "";
                          bool isSource = v.selectedController == v.controllerList.first;
                          bool isDestination = v.selectedController == v.controllerList.last;
                          v.updateSelectedTextField(selectedText, isSource: isSource, isDestination: isDestination);
                        },
                      ),
                      Divider(height: 0, color: AppColors.borderColor.withOpacity(0.2))
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
