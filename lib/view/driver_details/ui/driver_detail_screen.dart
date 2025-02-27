import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/components/dotted_line.dart';
import 'package:flutter_easy_ride/view/components/vertical_text.dart';
import 'package:flutter_easy_ride/view/driver_details/provider/driver_details_provider.dart';
import 'package:flutter_easy_ride/view/payments/wallet_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:slidable_button/slidable_button.dart';

class DriverDetailScreen extends StatelessWidget {
  const DriverDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 450,
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
              padding: EdgeInsets.only(top: 15, right: 15, left: 15),
              height: MediaQuery.of(context).size.height - 320,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.watch<DriverDetailsProvider>().isConfirmed
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Driver’s Details",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.yellowDark.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text("Your Code", style: TextStyle(fontSize: 12)),
                                  Text(
                                    "4080",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 8),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: Text(
                            "Driver’s Details",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DottedLine(),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Arriving within ",
                            style: TextStyle(fontSize: 12, color: AppColors.black),
                            children: [
                              TextSpan(
                                  text: "7 mins",
                                  style: TextStyle(fontSize: 12, color: AppColors.black, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration:
                              BoxDecoration(color: AppColors.lightYellow, borderRadius: BorderRadius.circular(14)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(AppImage.driver),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Rahul Sharma",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                        Text(
                                          "9027543218",
                                          style: TextStyle(fontSize: 14, decoration: TextDecoration.underline),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.green,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(AppImage.star),
                                              SizedBox(width: 4),
                                              Text(
                                                "4.5",
                                                style: TextStyle(
                                                    fontSize: 12, color: AppColors.white, fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "White Maruti Swift",
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 3),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                          color: AppColors.yellowDark,
                                          child: Text("UP14 CC 4080"),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Image.asset(height: 85, width: 100, AppImage.primeCar),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Stack(
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
                                                    hintText: "Muradnagr, Ghaziabad",
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.all(10),
                                                  ),
                                                  Divider(
                                                      color: AppColors.black.withOpacity(0.1),
                                                      endIndent: 30,
                                                      height: 0),
                                                  CommonTextField(
                                                    hintText: "Sec 57, Gurugram, Haryana",
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
                              ],
                            ),
                            Positioned(
                              right: 15,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border: Border.all(color: AppColors.black.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(12)),
                                padding: EdgeInsets.all(5.0),
                                child: Text("16.3km", style: TextStyle(fontSize: 12)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price Details",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Conv. Charges",
                                    style: TextStyle(color: AppColors.black.withOpacity(0.8)),
                                  ),
                                  Text(
                                    "₹20",
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Fare",
                                    style: TextStyle(color: AppColors.black.withOpacity(0.8)),
                                  ),
                                  Text(
                                    "₹270",
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              DottedLine(),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Amt Payable",
                                    style: TextStyle(fontSize: 18, color: AppColors.black.withOpacity(0.8)),
                                  ),
                                  Text(
                                    "₹290",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppImage.wallet),
                                            SizedBox(width: 5),
                                            Text("Wallet", style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "Available Bal: ",
                                            style: TextStyle(fontSize: 12, color: AppColors.black),
                                            children: [
                                              TextSpan(
                                                  text: "₹2290.0",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.black,
                                                      fontWeight: FontWeight.w500)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.arrow_forward_ios_rounded, size: 20),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                  )
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
            if (!context.watch<DriverDetailsProvider>().isConfirmed) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalText(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    title: "Your Ride is Ready!",
                    subTitle: "Confirm before your ride gets canceled",
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Spacer(),
                  Text(
                    "0:60",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.blue),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: CommonButton(
                    labelSize: 14,
                    onPressed: () {},
                    img: AppImage.close,
                    label: "Cancel Ride",
                    horizontalPadding: 10,
                    labelColor: AppColors.redColor.withOpacity(0.7),
                    buttonColor: AppColors.white,
                    buttonBorderColor: AppColors.redColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(width: 10),
                context.watch<DriverDetailsProvider>().isConfirmed
                    ? Expanded(
                        flex: 12,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(color: AppColors.borderColor.withOpacity(0.8)),
                            ),
                            child: HorizontalSlidableButton(
                              width: MediaQuery.of(context).size.width,
                              height: 52,
                              buttonWidth: 52,
                              color: AppColors.borderColor.withOpacity(0.8),
                              buttonColor: AppColors.white,
                              dismissible: false,
                              label: Icon(Icons.phone),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.arrow_forward_ios_outlined, color: AppColors.white, size: 18),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: AppColors.white.withOpacity(0.7), size: 18),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: AppColors.white.withOpacity(0.3), size: 18),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      "Call",
                                      style:
                                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                              onChanged: (position) {
                                if (position == SlidableButtonPosition.end) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => WalletScreen(backVisible: true)),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 12,
                        child: CommonButton(
                          labelSize: 14,
                          horizontalPadding: 10,
                          label: "Confirm Booking",
                          onPressed: () => context.read<DriverDetailsProvider>().confirmRide(),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
