import 'package:flutter/material.dart';
import '../../common_widget/cabtextformfield.dart';
import 'customanimation.dart';

class TravelHomePage extends StatelessWidget {
  const TravelHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lime,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            CustomAnimatedWidget(
              beginOffset: const Offset(0, -1),
              endOffset: Offset.zero,
              duration: const Duration(seconds: 2),
              child: Column(
                children: const [
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Happy January',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAnimatedWidget(
                beginOffset: const Offset(0, -1),
                endOffset: Offset.zero,
                duration: const Duration(seconds: 2),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.lime,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "From",
                            style: TextStyle(color: Colors.black),
                          ),
                          Spacer(),
                          Icon(Icons.swap_vert, color: Colors.white),
                        ],
                      ),
                      CabTextFormField(
                        prefixIcon: Icons.search,
                        hintText: 'Where to go ?',
                      ),
                      const Divider(color: Colors.white24),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomAnimatedWidget(
                beginOffset: const Offset(0, 1),
                endOffset: Offset.zero,
                duration: const Duration(seconds: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.directions_car, size: 60),
                            Text("Book Now", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.directions_car, size: 55),
                            Text("Prebooking", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Discount Flights",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomAnimatedWidget(
                beginOffset: const Offset(1, 0),
                endOffset: Offset.zero,
                duration: const Duration(seconds: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: const [
                      Text(
                        "\$300",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
