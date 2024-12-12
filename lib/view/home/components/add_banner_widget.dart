import 'package:flutter/material.dart';

class AddBannerWidget extends StatefulWidget {
  const AddBannerWidget({super.key});

  @override
  State<AddBannerWidget> createState() => _FirstState();
}

class _FirstState extends State<AddBannerWidget> {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/car1.jpg',
      'title': 'Go with Easy rides',
      'subtitle': 'Doorstep pick up, no bargaining'
    },
    {
      'image': 'assets/images/car2.jpg',
      'title': 'Go with Easy rides',
      'subtitle': 'Doorstep pick up, no bargaining'
    },
    {
      'image': 'assets/images/car3.jpg',
      'title': 'Go with Easy rides',
      'subtitle': 'Doorstep pick up, no bargaining'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      height: 140,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(item['image']!),
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black87,
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['subtitle']!,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
