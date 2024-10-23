import 'package:flutter/material.dart';

class RentaleRecurringLocationAddWidget extends StatefulWidget {
  final TextEditingController pickupController;
  final TextEditingController dropController;
  Function(String) onChange;

  RentaleRecurringLocationAddWidget({
    required this.pickupController,
    required this.dropController,
    required this.onChange,
  });

  @override
  _RentaleRecurringLocationAddWidgetState createState() =>
      _RentaleRecurringLocationAddWidgetState();
}

class _RentaleRecurringLocationAddWidgetState
    extends State<RentaleRecurringLocationAddWidget> {
  List<TextEditingController> stopControllers = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xfff3fdf6),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3), // changes the position of the shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pickup Location Input
            _buildLocationInput(
              controller: widget.pickupController,
              icon: Icons.location_on_rounded,
              iconColor: Colors.green,
              hint: 'Pickup location',
            ),

            // Tracker Icon with vertical line
            _buildTrackerIcon(),

            // Drop Location Input
            _buildLocationInput(
              controller: widget.dropController,
              icon: Icons.location_on_rounded,
              iconColor: Colors.red,
              hint: 'Drop location',
            ),

            // Dynamically added stops
            ..._buildStopInputs(),

            // Add stop button
            _buildAddStop()
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStopInputs() {
    return stopControllers.asMap().entries.map((entry) {
      int index = entry.key;
      TextEditingController controller = entry.value;

      return Column(
        children: [
          const SizedBox(height: 10),
          _buildLocationInput(
            controller: controller,
            icon: Icons.location_on_rounded,
            iconColor: Colors.blue,
            hint: 'Stop ${index + 1} location',
          ),
        ],
      );
    }).toList();
  }

  Widget _buildLocationInput({
    required TextEditingController controller,
    required IconData icon,
    required Color iconColor,
    required String hint,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 5.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: TextFormField(
              cursorColor: Colors.white,
              onChanged: (value) => widget.onChange(value),
              controller: controller,
              style: const TextStyle(color: Colors.black), // Text color inside the field
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrackerIcon() {
    return Row(
      children: [
        Container(
          height: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.more_vert, color: Colors.black54, size: 24.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddStop() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                stopControllers.add(TextEditingController());
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xff1937d7),
                  width: 1.0, // Border width
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10,
                child: Icon(
                  Icons.add,
                  size: 15,
                  color: Color(0xff1937d7),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Text(
            'Add stops',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 15,
              color: Color(0xff1937d7),
            ),
          ),
        ],
      ),
    );
  }
}
