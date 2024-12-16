// import 'package:flutter/material.dart';
//
// class PickupDropWidget extends StatelessWidget {
//   final TextEditingController pickupController;
//   final TextEditingController dropController;
//   Function(String) onChange;
//
//   PickupDropWidget(
//       {required this.pickupController,
//       required this.dropController,
//       required this.onChange});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       // Enable scrolling for overflowing content
//       child: Container(
//         padding: const EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: Color(0xff1937d7), // Light background color for the container
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(20),
//               bottomLeft: Radius.circular(20)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 5,
//               blurRadius: 10,
//               offset: Offset(0, 3), // changes the position of the shadow
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Pickup Location Input
//             _buildLocationInput(
//               controller: pickupController,
//               icon: Icons.location_on_rounded,
//               iconColor: Colors.green,
//               hint: 'Pickup location',
//             ),
//
//             // Tracker Icon with vertical line
//             _buildTrackerIcon(),
//
//             // Drop Location Input
//             _buildLocationInput(
//               controller: dropController,
//               icon: Icons.location_on_rounded,
//               iconColor: Colors.red,
//               hint: 'Drop location',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLocationInput({
//     required TextEditingController controller,
//     required IconData icon,
//     required Color iconColor,
//     required String hint,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Icon(icon, color: iconColor, size: 30),
//         const SizedBox(width: 5.0),
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white
//                   .withOpacity(0.3), // Background color of the text field
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.white12, width: 1.5),
//             ),
//             child: TextFormField(
//               cursorColor: Colors.white,
//               onChanged: (value) => onChange(value),
//               controller: controller,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: "Poppins",
//                   fontSize: 14),
//               decoration: InputDecoration(
//                 hintText: hint,
//                 hintStyle: const TextStyle(
//                     color: Colors.white60,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: "Poppins",
//                     fontSize: 14),
//                 border: InputBorder.none,
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTrackerIcon() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           Container(
//             height: 40,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.more_vert, color: Colors.white, size: 24.0),
//                 // Container(height: 20, width: 2, color: Colors.grey.shade400),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Divider(color: Colors.white30, thickness: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class PickupDropWidget extends StatelessWidget {
  final TextEditingController pickupController;
  final TextEditingController dropController;
  final Function(String) onPickupChange; // Separate onChange for pickup location
  final Function(String) onDropChange; // Separate onChange for drop location
  final Function()? onTap; // Separate onChange for drop location

  PickupDropWidget({
    required this.pickupController,
    required this.dropController,
    required this.onPickupChange, // New parameter
    required this.onDropChange, // New parameter
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Enable scrolling for overflowing content
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color(0xff1937d7), // Light background color for the container
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
              controller: pickupController,
              icon: Icons.location_on_rounded,
              iconColor: Colors.green,
              hint: 'Pickup location',
              onChange: onPickupChange, // Call onPickupChange here
            ),

            // Tracker Icon with vertical line
            _buildTrackerIcon(),

            // Drop Location Input
            _buildLocationInput(
              controller: dropController,
              icon: Icons.location_on_rounded,
              iconColor: Colors.red,
              hint: 'Drop location',
              onChange: onDropChange, // Call onDropChange here
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInput({
    required TextEditingController controller,
    required IconData icon,
    required Color iconColor,
    required String hint,
    required Function(String) onChange, // Accept onChange for this field
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: iconColor, size: 30),
        const SizedBox(width: 5.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3), // Background color of the text field
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12, width: 1.5),
            ),
            child: TextFormField(
              onTap: onTap,
              cursorColor: Colors.white,
              onChanged: (value) => onChange(value), // Trigger the onChange function
              controller: controller,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrackerIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.more_vert, color: Colors.white, size: 24.0),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Divider(color: Colors.white30, thickness: 1.5),
          ),
        ],
      ),
    );
  }
}
