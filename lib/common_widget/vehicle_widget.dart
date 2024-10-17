import 'package:flutter/material.dart';

class VehicleListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String time;
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  VehicleListItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.time,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the onTap function passed from the parent
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
           // color: isSelected ? Color(0xff1937d7) : Colors.transparent, // Background color based on selection
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent, // Border color based on selection
              width: 2, // Width of the border
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.network(
                assetPath,
                width: 60,
                height: 50,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected ? Colors.blue : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.blue : Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    " ₹$price",
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected ? Colors.blue : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.blue : Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
