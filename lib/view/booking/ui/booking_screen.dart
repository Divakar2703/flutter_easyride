import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/booking/provider/common_provider.dart';
import 'package:flutter_easy_ride/view/booking/ui/book_now_screen.dart';
import 'package:flutter_easy_ride/view/booking/ui/pre_booking_screen.dart';
import 'package:flutter_easy_ride/view/booking/ui/rental_screen.dart';
import 'package:flutter_easy_ride/view/components/image_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController sourceLocation = TextEditingController();
  TextEditingController destination = TextEditingController();
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookNowProvider>().addLocationTextFields(sourceLocation, destination, address);
      // Provider.of<BookNowProvider>(context, listen: false).getDropHistoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (d, r) => context.read<BookNowProvider>().resetAllData(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: context.watch<CommonProvider>().selectedIndex == 2
                    ? MediaQuery.of(context).size.height - 400
                    : MediaQuery.of(context).size.height - 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: AppColors.white),
                child: Consumer<BookNowProvider>(
                  builder: (context, v, child) => v.isLoading
                      ? Indicator()
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(target: v.currentLocation ?? LatLng(0, 0), zoom: 15),
                          zoomControlsEnabled: false,
                          onMapCreated: (c) => _mapController = c,
                          onTap: (l) => v.addLocationMarkers(l),
                          markers: v.markers.isNotEmpty ? v.markers : {},
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
                  height: context.watch<CommonProvider>().selectedIndex == 2
                      ? MediaQuery.of(context).size.height / 1.7
                      : MediaQuery.of(context).size.height - 200,
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
                      padding: const EdgeInsets.all(15.0),
                      child: Consumer<CommonProvider>(
                        builder: (context, v, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ImageTextWidget(
                                    title: "Book Now",
                                    isBorderView: true,
                                    isSelected: v.selectedIndex == 0,
                                    image: AppImage.bookNow,
                                    subImage: AppImage.bookNowIcon,
                                    mainAxisSize: MainAxisSize.min,
                                    onTap: () => v.changeBooking(0),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: ImageTextWidget(
                                    title: "Per-Booking",
                                    isBorderView: true,
                                    mainAxisSize: MainAxisSize.min,
                                    image: AppImage.preBooking,
                                    subImage: AppImage.preBookingIcon,
                                    isSelected: v.selectedIndex == 1,
                                    onTap: () => v..changeBooking(1),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: ImageTextWidget(
                                    title: "Rental",
                                    isBorderView: true,
                                    mainAxisSize: MainAxisSize.min,
                                    image: AppImage.rental,
                                    subImage: AppImage.rentalIcon,
                                    isSelected: v.selectedIndex == 2,
                                    onTap: () => v..changeBooking(2),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            v.selectedIndex == 0
                                ? BookNowScreen()
                                : v.selectedIndex == 1
                                    ? PreBookingScreen()
                                    : RentalScreen()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
