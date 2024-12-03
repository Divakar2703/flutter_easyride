import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';

class RentalLocationSelectView extends StatefulWidget {
  const RentalLocationSelectView({super.key});

  @override
  State<RentalLocationSelectView> createState() =>
      _RentalLocationSelectViewState();
}

class _RentalLocationSelectViewState extends State<RentalLocationSelectView> {
  final _selectedSegment = ValueNotifier('inventory'); // 'inventory' is selected initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Column(
        children: [
          // AdvancedSegment controller
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AdvancedSegment(
              segments: {
                'inventory': 'Hourly Rentals',
                'products': 'Recurring Rentals',
              },
             controller: _selectedSegment,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey.shade300,
              sliderColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Render different widgets based on the selected segment
          ValueListenableBuilder(
            valueListenable: _selectedSegment,
            builder: (context, value, child) {
              if (value == 'inventory') {
                return const A(); // Display the A widget for "inventory"
              } else {
                return const B(); // Display the B widget for "products"
              }
            },
          ),
        ],
      ),
    );
  }
}

// Example A widget
class A extends StatelessWidget {
  const A({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Hourly Rentals (A)',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Example B widget
class B extends StatelessWidget {
  const B({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Recurring Rentals (B)',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
