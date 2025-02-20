import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/car_selection/provider/car_selection_provider.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_tile_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../driver_details/ui/driver_detail_screen.dart';

class CarSelectionScreen extends StatelessWidget {
  const CarSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 480,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppColors.white),
            child: GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(18.512457, 73.843106),
              ),
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.2),
                      offset: Offset(0, -4),
                      blurRadius: 18,
                    )
                  ],
                ),
                child: SvgPicture.asset(AppImage.back),
              ),
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height - 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: BorderDirectional(top: BorderSide(color: AppColors.yellow)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    offset: Offset(0, -4),
                    blurRadius: 18,
                  )
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Text(
                    "Choose Your Ride",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(20),
                      itemCount: context.read<CarSelectionProvider>().carList.length,
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) => CommonTileView(
                          image: context.read<CarSelectionProvider>().carList[index].image,
                          time: context.read<CarSelectionProvider>().carList[index].time,
                          title: context.read<CarSelectionProvider>().carList[index].title,
                          price: context.read<CarSelectionProvider>().carList[index].price,
                          subTitle: context.read<CarSelectionProvider>().carList[index].subTitle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.08),
              offset: Offset(0, -4),
              blurRadius: 14,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppImage.wallet),
                SizedBox(width: 5),
                Text("Wallet", style: TextStyle(fontSize: 16)),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, size: 20)
              ],
            ),
            SizedBox(height: 10),
            CommonButton(
              label: "Confirm",
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DriverDetailScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
