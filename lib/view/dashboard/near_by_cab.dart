import 'package:flutter/material.dart';

class NearByCab extends StatefulWidget {
  const NearByCab({super.key});

  @override
  State<NearByCab> createState() => _NearByCabState();
}

class _NearByCabState extends State<NearByCab> {

  final List<Map<String, String>> cabs = [
    {'name': 'Cab 1', 'availability': 'Available now', 'image': 'assets/images/cab_one.png'},
    {'name': 'Cab 2', 'availability': 'Available in 5 minutes', 'image': 'assets/images/cab_two.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cabs.length,
        itemBuilder: (context, index) {

          return _buildCabContainer(
            cabs[index]['name']!,
            cabs[index]['availability']!,
            cabs[index]['image']!,
          );
        },
      ),
    );
  }

  Widget _buildCabContainer(String cabName, String availability, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 12, top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cabName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
                const  SizedBox(height: 5),
                Text(
                  availability,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
