import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
              child: Consumer<BookNowProvider>(
                builder: (context, v, child) => Container(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: v.locationTextfieldList.length == 2
                                    ? [SvgPicture.asset(AppImage.dottedLine)]
                                    : List.generate(
                                        v.locationTextfieldList.length,
                                        (index) => index == 0 || index == v.locationTextfieldList.length - 1
                                            ? SizedBox.shrink()
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(AppImage.dottedLine, height: 20),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration:
                                                        BoxDecoration(color: AppColors.yellow, shape: BoxShape.circle),
                                                    child: Center(
                                                      child: Text("$index"),
                                                    ),
                                                  ),
                                                  index == v.locationTextfieldList.length - 2
                                                      ? SvgPicture.asset(AppImage.dottedLine, height: 20)
                                                      : SizedBox.shrink()
                                                ],
                                              ),
                                      ),
                              ),
                              SizedBox(height: 1),
                              SvgPicture.asset(AppImage.location),
                            ],
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: context
                                  .watch<BookNowProvider>()
                                  .locationTextfieldList
                                  .map(
                                    (e) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        e,
                                        v.locationTextfieldList.last == e
                                            ? SizedBox.shrink()
                                            : Divider(color: AppColors.black.withOpacity(0.1), height: 0),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
        Positioned(
          right: -5,
          child: InkWell(
            onTap: () => context.read<BookNowProvider>().addLocations(),
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
          ),
        )
      ],
    );
  }
}
