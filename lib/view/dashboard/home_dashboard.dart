import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/common_widget/shimmer_loader.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:flutter_easy_ride/view/dashboard/pending_booking_card.dart';
import 'package:flutter_easy_ride/view/home/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../home/components/banner_slider.dart';
import '../tracking/tracking.dart';
import 'dashboard/pre_booking_rental_book_now_card.dart';
import 'near_by_cab.dart';

class HomeDashboard extends StatefulWidget {
  final ScrollController scrollController;

  const HomeDashboard({Key? key, required this.scrollController}) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  void initState() {
    super.initState();
    Provider.of<BookNowProvider>(context, listen: false).fetchCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xffF8F7F7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ListView(
        // shrinkWrap: true,
        controller: widget.scrollController,
        children: [
          Center(
            child: Container(
              width: 50, // Width of the line
              height: 5, // Thickness of the line
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Nearby Cabs',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 15),
          Consumer<DashboardProvider>(
            builder: (BuildContext context, DashboardProvider value, Widget? child) {
              return value.vehicleResponse == null
                  ? Center(
                      child: Text("No vehicles available"),
                    )
                  : NearByCab(
                      vehicleResponse: value.vehicleResponse,
                    );
            },
          ),
          const SizedBox(height: 15),
          const PreBookingRentalBookNowCard(),
          const SizedBox(height: 15),
          Consumer<DashboardProvider>(
            builder: (BuildContext context, value, Widget? child) {
              if (!value.loading) {
                return BannerSlider(
                  banners: value.dashboardResponse!.banner,
                );
              } else {
                return ShimmerLoader();
              }
            },
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffE3F2FD),
                      Colors.blue.shade300,
                    ],
                  ),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0), // Adds some padding around the text
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pending Bookings',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.start, // Centers the text within the container
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.double_arrow),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffE3F2FD),
                    Colors.blue.shade300,
                  ],
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
            child: Consumer<DashboardProvider>(
              builder: (BuildContext context, DashboardProvider value, Widget? child) {
                return value.bookinglist.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.bookinglist.length,
                        itemBuilder: (context, index) {
                          var data = value.bookinglist[index];
                          return InkWell(
                            onTap: () {
//Navigator.push(context, MaterialPageRoute(builder: (context)=>RideTrackingScreen(bookingId: data.bookId,drop_lat: data.drop_lat,drop_long: data.drop_long,)));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapTrackingScreen(
                                            booking: data,
                                          )));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: PendingBookingCard(
                                bookingID: data.bookId,
                                entryTime: data.entryDate,
                              ), // Replace with actual widget
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text("No pending bookings"),
                      );
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
