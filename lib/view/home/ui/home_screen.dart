import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/provider/common_provider.dart';
import 'package:flutter_easy_ride/view/booking/ui/booking_screen.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/components/image_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 250,
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(99),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.2),
                        offset: Offset(0, 4),
                        blurRadius: 12,
                      )
                    ],
                  ),
                  child: Image.asset(AppImage.appLogo, width: 40, height: 40),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CommonTextField(
                    borderRadius: 12,
                    hintText: "Set Destination",
                    fillColor: AppColors.white.withOpacity(0.7),
                    borderColor: AppColors.borderColor.withOpacity(0.1),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(AppImage.menu, width: 24, height: 24),
                    ),
                    suffix: SvgPicture.asset(AppImage.search, width: 24, height: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.6,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Text("Today's Offer", style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(AppImage.offer)),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -80,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ImageTextWidget(
                            title: "Book Now",
                            image: AppImage.bookNow,
                            subImage: AppImage.bookNowIcon,
                            onTap: () {
                              context.read<CommonProvider>().changeBooking(0);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ImageTextWidget(
                            title: "Per-Booking",
                            image: AppImage.preBooking,
                            subImage: AppImage.preBookingIcon,
                            onTap: () {
                              context.read<CommonProvider>().changeBooking(1);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ImageTextWidget(
                            title: "Rental",
                            image: AppImage.rental,
                            subImage: AppImage.rentalIcon,
                            onTap: () {
                              context.read<CommonProvider>().changeBooking(2);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
