import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';
import 'package:flutter_easy_ride/view/booking/provider/common_provider.dart';
import 'package:flutter_easy_ride/view/booking/ui/booking_screen.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/components/image_text_widget.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:flutter_easy_ride/view/home/provider/dashboard_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Provider.of<BottomBarProvider>(context, listen: false).fetchCurrentLocation());
    Provider.of<ApiProvider>(context, listen: false).fetchAuth();
    Provider.of<DashboardProvider>(context, listen: false).fetchDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Consumer<BottomBarProvider>(
          builder: (context, v, child) => Container(
            height: MediaQuery.of(context).size.height - 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppColors.white),
            child: v.isLoading
                ? Indicator()
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: v.currentLocation ?? LatLng(0, 0),
                      zoom: 15,
                    ),
                    onMapCreated: (c) => _mapController = c,
                    markers: v.markers,
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
                    hintText: "Your Location",
                    onTap: () {
                      context.read<CommonProvider>().changeBooking(0);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                    },
                    con: context.watch<BottomBarProvider>().homeSearchCon,
                    fillColor: AppColors.white.withOpacity(0.7),
                    borderColor: AppColors.borderColor.withOpacity(0.1),
                    // prefixIcon: Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: SvgPicture.asset(AppImage.menu, width: 24, height: 24),
                    // ),
                    // suffix: SvgPicture.asset(AppImage.search, width: 24, height: 24),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        Text("Today's Offer", style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(height: 15),
                        Consumer<DashboardProvider>(
                          builder: (BuildContext context, value, Widget? child) => !value.loading
                              ? CarouselSlider(
                                  options: CarouselOptions(
                                    initialPage: 0,
                                    height: 160,
                                    viewportFraction: 1,
                                    aspectRatio: MediaQuery.of(context).size.width / 160,
                                    enableInfiniteScroll: true,
                                    autoPlay: value.dashboardResponse?.banner.length == 1 ? false : true,
                                    autoPlayInterval: const Duration(seconds: 5),
                                  ),
                                  items: (value.dashboardResponse?.banner ?? [])
                                      .map(
                                        (e) => Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10),
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.black.withOpacity(0.1)),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(e.appBannerImage, fit: BoxFit.fill),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : Indicator(),
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
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
