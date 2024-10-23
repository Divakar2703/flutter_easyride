import 'package:flutter/material.dart';

class RecurringRechargePacks extends StatefulWidget {
  const RecurringRechargePacks({super.key});

  @override
  State<RecurringRechargePacks> createState() => _RecurringRechargePacksState();
}

class _RecurringRechargePacksState extends State<RecurringRechargePacks> {
  // Data for the packs
  final List<Map<String, dynamic>> packs = [
    {
      'duration': '4 week',
      'cashback': 'Get Rs.534 cashback',
      'topup': 'on a top up of Rs.64646',
    },
    {
      'duration': '3 week',
      'cashback': 'Get Rs.344 cashback',
      'topup': 'on a top up of Rs.63521',
    },
    {
      'duration': '2 week',
      'cashback': 'Get Rs.334 cashback',
      'topup': 'on a top up of Rs.965663',
    },
    {
      'duration': '3 week',
      'cashback': 'Get Rs.344 cashback',
      'topup': 'on a top up of Rs.63521',
    },
  ];

  // Index of the selected pack
  int? selectedPackIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: packs.length,
        itemBuilder: (context, index) {
          final pack = packs[index];
          bool isSelected = selectedPackIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPackIndex = index; // Mark this item as selected
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xffdbe0f8) : Colors.white,
                border: Border.all(
                    color: isSelected ?  Color(0xff1937d7) : Colors.black54),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    pack['duration'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 18.5,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.black54,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pack['cashback'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        pack['topup'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
