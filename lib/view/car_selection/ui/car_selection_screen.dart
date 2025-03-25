import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/common_widget/payment_methods_widget.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/car_selection/provider/car_selection_provider.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_tile_view.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:flutter_easy_ride/view/payments/provider/payment_provider.dart';
import 'package:flutter_easy_ride/view/payments/ui/wallet_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
            child: Consumer<BookNowProvider>(
              builder: (context, v, child) => v.isLoading
                  ? Indicator()
                  : GoogleMap(
                      markers: v.markers,
                      polylines: v.polyLines,
                      zoomControlsEnabled: false,
                      // onMapCreated: (c) => _mapController = c,
                      // onTap: (l) => v.addLocationMarkers(l),
                      initialCameraPosition: CameraPosition(target: v.currentLocation ?? LatLng(0, 0), zoom: 15),
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
                  Consumer<CarSelectionProvider>(
                    builder: (context, v, child) => Expanded(
                      child: v.loading
                          ? ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(20),
                              itemCount: 4,
                              // Show 5 shimmer items
                              separatorBuilder: (context, index) => SizedBox(height: 10),
                              itemBuilder: (context, index) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withOpacity(0.1),
                                        offset: Offset(0, 2),
                                        blurRadius: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : v.vehicleList.isEmpty
                              ? Center(child: Text("Vehicles not available at this location."))
                              : ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(20),
                                  itemCount: context.read<CarSelectionProvider>().vehicleList.length,
                                  separatorBuilder: (context, index) => SizedBox(height: 10),
                                  itemBuilder: (context, index) => CommonTileView(
                                      onTap: () => v.carSelection(index),
                                      isSelected: context.read<CarSelectionProvider>().vehicleList[index].isSelected,
                                      image: context.read<CarSelectionProvider>().vehicleList[index].image,
                                      time: context.read<CarSelectionProvider>().vehicleList[index].travelTime,
                                      title: context.read<CarSelectionProvider>().vehicleList[index].name,
                                      price: "₹${context.read<CarSelectionProvider>().vehicleList[index].fare}",
                                      subTitle: context.read<CarSelectionProvider>().vehicleList[index].description),
                                ),
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
            InkWell(
              onTap: () => _showPaymentMethodBottomSheet(context),
              child: Row(
                children: [
                  SvgPicture.asset(AppImage.wallet),
                  SizedBox(width: 5),
                  Consumer<BookNowProvider>(
                      builder: (context, v, child) =>
                          Text(context.watch<PaymentProvider>().selectedPaymentMethod, style: TextStyle(fontSize: 16))),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded, size: 20)
                ],
              ),
            ),
            SizedBox(height: 10),
            CommonButton(
              label: "Confirm",
              onPressed: () {
                context.read<CarSelectionProvider>().saveRequestToDriver(
                      context.read<BookNowProvider>().markerPositions,
                      context.read<BookNowProvider>().locationTextfieldList,
                      context.read<BottomBarProvider>().bookingTypeIndex,
                    );
                if (context.read<PaymentProvider>().selectedPaymentMethod == "wallet") {
                  final selectedItem = context.read<CarSelectionProvider>().vehicleList.firstWhere((e) => e.isSelected);
                  if (double.parse(context.read<CarSelectionProvider>().vehicleModel?.data?.walletAmount ?? "0") >
                      double.parse(selectedItem.fare ?? "0")) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DriverDetailScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
                  }
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DriverDetailScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentMethodBottomSheet(BuildContext context) async {
    await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => PaymentMethodBottomSheet(),
    );
  }
}
