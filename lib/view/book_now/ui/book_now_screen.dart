import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/book_now/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/components/image_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BookNowScreen extends StatelessWidget {
  const BookNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 500,
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
              height: MediaQuery.of(context).size.height - 200,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextWidget(
                                mainAxisSize: MainAxisSize.min,
                                image: AppImage.bookNow,
                                subImage: AppImage.bookNowIcon,
                                title: "Book Now"),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: ImageTextWidget(
                                mainAxisSize: MainAxisSize.min,
                                image: AppImage.preBooking,
                                subImage: AppImage.preBookingIcon,
                                title: "Per-Booking"),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: ImageTextWidget(
                                mainAxisSize: MainAxisSize.min,
                                image: AppImage.rental,
                                subImage: AppImage.rentalIcon,
                                title: "Rental"),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
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
                                                  hintText: "Source",
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.all(10),
                                                ),
                                                Divider(color: AppColors.black.withOpacity(0.1), height: 0),
                                                CommonTextField(
                                                  hintText: "Destination",
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
                              SizedBox(width: 20)
                            ],
                          ),
                          Positioned(
                            right: -5,
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
                          )
                        ],
                      ),
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

                      ///Pre Booking
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Schedule a Ride", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          SvgPicture.asset(AppImage.calender)
                        ],
                      ),
                      SizedBox(height: 10),
                      HorizontalCalendar()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalCalendar extends StatefulWidget {
  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime _selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrentDate());
  }

  void _scrollToCurrentDate() {
    final double itemWidth = 60.0;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int currentDateIndex = _selectedDate.day - DateTime.now().day;
    final double offset = (currentDateIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: 30,
            itemBuilder: (context, index) {
              DateTime date = DateTime.now().add(Duration(days: index - 30)); // Center around today
              bool isSelected =
                  _selectedDate.day == date.day && _selectedDate.month == date.month && _selectedDate.year == date.year;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${date.day}',
                            style: TextStyle(
                              fontSize: isSelected ? 16 : 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppColors.yellow : AppColors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            '${_getDayOfWeek(date.weekday)}',
                            style: TextStyle(
                              fontSize: isSelected ? 14 : 12,
                              color: isSelected ? AppColors.yellow : AppColors.black.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 3,
                            width: double.infinity,
                            color: isSelected ? AppColors.yellow : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(width: 0, indent: 15, endIndent: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
