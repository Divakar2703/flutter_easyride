import 'package:flutter/material.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

class CarSelectContainer extends StatefulWidget {
  const CarSelectContainer({Key? key}) : super(key: key);

  @override
  State<CarSelectContainer> createState() => _CarSelectContainerState();
}

class _CarSelectContainerState extends State<CarSelectContainer> {
  int selectedRow = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCarRow(0,
            'Just go',
            'Near by you',
            'Rs 25.00',
            '2 min',
            'assets/images/car_one.png'
        ),
        buildCarRow(1,
            'Another text',
            'Another nearby location',
            'Rs 30.00',
            '3 min',
            'assets/images/bike.png'
        ),
        buildCarRow(2,
            'Just go',
            'Near by you',
            'Rs 25.00',
            '2 min',
            'assets/images/car_one.png'
        ),
        buildCarRow(3,
            'Another text',
            'Another nearby location',
            'Rs 30.00',
            '3 min',
            'assets/images/car.webp'
        ),
      ],
    );
  }

  Widget buildCarRow(int index,
      String title,
      String subtitle,
      String price,
      String time,
      String assetPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRow = index; // Update selected row on tap
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
        child: Container(
          color: selectedRow == index ? kDarkBlueColor : Colors.transparent,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset(
                assetPath,
                width: 60,
                height: 50,
              //  color: selectedRow == index ? Colors.white : Colors.black87,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedRow == index ? Colors.white : Colors.black87,
                      fontFamily: 'Poppins', // Set Poppins as the default font

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedRow == index ? Colors.white : Colors.grey.shade500,
                      fontFamily: 'Poppins', // Set Poppins as the default font

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
                    price,
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedRow == index ? Colors.white : Colors.black87,
                      fontFamily: 'Poppins', // Set Poppins as the default font

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedRow == index ? Colors.white : Colors.grey.shade500,
                      fontFamily: 'Poppins', // Set Poppins as the default font

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

