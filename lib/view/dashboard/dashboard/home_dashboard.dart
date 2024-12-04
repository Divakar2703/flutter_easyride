import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/view/dashboard/dashboard/pending_booking_card.dart';
import 'package:flutter_easy_ride/view/dashboard/dashboard/pre_booking_rental_book_now_card.dart';
import 'package:flutter_easy_ride/view/dashboard/dashboard/pre_booking_schedule_card.dart';


import 'near_by_cab.dart';


class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/map.png',
            height: screenHeight,
            width: screenWidth,
            fit: BoxFit.cover,
          ),

          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Material(
                    color: Colors.white,
                    elevation: 3.0,
                    shape: const CircleBorder(),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {

                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Cab Booking',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Spacer(),
                  Material(
                    color: Colors.white,
                    elevation: 3.0,
                    shape: const CircleBorder(),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {

                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 110,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
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
          ),

        ],
      ),
    );
  }
}
