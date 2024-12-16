  // import 'package:flutter/material.dart';
  // import 'package:flutter_easy_ride/view/dashboard/pending_booking_card.dart';
  // import 'package:flutter_easy_ride/view/dashboard/pre_booking_rental_book_now_card.dart';
  // import 'package:flutter_easy_ride/view/dashboard/pre_booking_schedule_card.dart';
  //
  //
  // import 'near_by_cab.dart';
  //
  //
  // class HomeDashboard extends StatefulWidget {
  //   final ScrollController scrollController;
  //
  //    HomeDashboard({super.key,required this.scrollController});
  //
  //   @override
  //   State<HomeDashboard> createState() => _HomeDashboardState();
  // }
  //
  // class _HomeDashboardState extends State<HomeDashboard> {
  //   @override
  //   Widget build(BuildContext context) {
  //
  //     return Scaffold(
  //       body: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 16),
  //         decoration: const BoxDecoration(
  //           color: Color(0xFFF1F8FF),
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(24),
  //               topRight: Radius.circular(24)
  //           ),
  //         ),
  //         child: SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const SizedBox(height: 25),
  //               const Text(
  //                 'Nearby Cabs',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.black87,
  //                   fontSize: 16,
  //                   fontFamily: 'Poppins',
  //                 ),
  //               ),
  //               const NearByCab(),
  //
  //               const SizedBox(height: 15),
  //              const  PreBookingRentalBookNowCard(),
  //
  //               const SizedBox(height: 15),
  //               const PreBookingScheduleCard(),
  //
  //               const SizedBox(height: 25),
  //               const Text(
  //                 'Pending Bookings',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.black87,
  //                   fontSize: 16,
  //                   fontFamily: 'Poppins',
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //
  //
  //               ListView.builder(
  //                 padding: EdgeInsets.zero,
  //                 shrinkWrap: true,
  //                 physics:const NeverScrollableScrollPhysics(),
  //                 itemCount: 5,
  //                 itemBuilder: (context, index) {
  //                   return Padding(
  //                     padding: const EdgeInsets.only(bottom: 8),
  //                     child: Material(
  //                   elevation: 2,
  //                   borderRadius: BorderRadius.circular(10),
  //                   child: Container(
  //                   padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //                   decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(10),
  //                   ),
  //                       child:const PendingBookingCard()),
  //                     )
  //                   );
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }


  import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/provider/dashboard_provider.dart';
import 'package:flutter_easy_ride/view/dashboard/pending_booking_card.dart';
import 'package:provider/provider.dart';
import '../../Book_Now/provider/cab_book_provider.dart';
import '../../provider/api_provider.dart';
import '../home/components/banner_slider.dart';
import '../tracking/ride_tracking.dart';
import '../tracking/tracking.dart';
import 'dashboard/pre_booking_rental_book_now_card.dart';
import 'dashboard/pre_booking_schedule_card.dart';
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
    // TODO: implement initState
    super.initState();


    }



    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Color(0xFFF1F8FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView(
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
                  return  NearByCab(vehicleResponse: value.vehicleResponse,);
                },
                ),
            const SizedBox(height: 15),
            const PreBookingRentalBookNowCard(),
            const SizedBox(height: 15),
             Consumer<DashboardProvider>(
                 builder: (BuildContext context, value, Widget? child) {
                   return BannerSlider(banners: value.dashboardResponse!.banner,);
                 },
             ),
            const SizedBox(height: 25),
            const Text(
              'Pending Bookings',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
             SizedBox(height: 20),
            Consumer<DashboardProvider>(
              builder: (BuildContext context, DashboardProvider value, Widget? child) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics:  NeverScrollableScrollPhysics(),
                  itemCount: value.bookinglist.length,
                  itemBuilder: (context, index) {
                    var data=value.bookinglist[index];
                    return InkWell(
                      onTap:(){
//Navigator.push(context, MaterialPageRoute(builder: (context)=>RideTrackingScreen(bookingId: data.bookId,drop_lat: data.drop_lat,drop_long: data.drop_long,)));
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MapTrackingScreen(booking: data,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: PendingBookingCard(bookingID: data.bookId, entryTime: data.entryDate,), // Replace with actual widget
                          ),
                        ),
                      ),
                    );
                  },
                );

              },
            ),
          ],
        ),
      );
    }
  }
