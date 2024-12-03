  import 'package:flutter/material.dart';
  import 'package:flutter_easy_ride/view/dashboard/pending_booking_card.dart';
  import 'package:flutter_easy_ride/view/dashboard/pre_booking_rental_book_now_card.dart';
  import 'package:flutter_easy_ride/view/dashboard/pre_booking_schedule_card.dart';


  import 'near_by_cab.dart';


  class HomeDashboard extends StatefulWidget {
    const HomeDashboard({super.key});

    @override
    State<HomeDashboard> createState() => _HomeDashboardState();
  }

  class _HomeDashboardState extends State<HomeDashboard> {
    @override
    Widget build(BuildContext context) {

      return Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Color(0xFFF1F8FF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24)
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const NearByCab(),

                const SizedBox(height: 15),
               const  PreBookingRentalBookNowCard(),

                const SizedBox(height: 15),
                const PreBookingScheduleCard(),

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
                const SizedBox(height: 20),


                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    ),
                        child:const PendingBookingCard()),
                      )
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
