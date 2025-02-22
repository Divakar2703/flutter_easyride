import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_easy_ride/rental/recurring/recurring_location_select_view.dart';
import 'package:flutter_easy_ride/rental/rental_location_select_view.dart';

import '../utils/colors.dart';

class RentalHourlyAndRecurringView extends StatefulWidget {
  const RentalHourlyAndRecurringView({super.key});

  @override
  State<RentalHourlyAndRecurringView> createState() => _RentalHourlyAndRecurringViewState();
}

class _RentalHourlyAndRecurringViewState extends State<RentalHourlyAndRecurringView> {
  final _selectedSegment = ValueNotifier('inventory'); // 'inventory' is selected initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: const Color(0xff1937d7),
        title: const Text(
          'Select Location',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 21),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          // Tabs (Segmented Control)
          Container(
            padding: const EdgeInsets.all(16),
            child: AdvancedSegment(
              segments: const {
                'inventory': 'Hourly Rentals',
                'products': 'Recurring Rentals',
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              controller: _selectedSegment,
              backgroundColor: AppColors.primaryBlue,
              sliderColor: Colors.white,
            ),
          ),

          // Dynamic content based on selected tab
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: _selectedSegment,
              builder: (context, value, child) {
                if (value == 'inventory') {
                  return RentalLocationSelectView(); // Display Hourly Rentals content
                } else if (value == 'products') {
                  return RecurringLocationSelectView(); // Display Recurring Rentals content
                }
                return const SizedBox(); // Default empty widget
              },
            ),
          ),
        ],
      ),
    );
  }
}
