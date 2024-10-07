import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0), // Adjust border radius as needed
      ),
      padding: EdgeInsets.all(8.0), // Adjust padding as needed
      child: SizedBox(
        width: double.infinity,
        height: 180,
        child: CarouselSlider(
          options: CarouselOptions(
            initialPage: 0, // Start from the first card
            viewportFraction: 0.9,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
          ),
          items: [
            'assets/images/banner_one.png',
            'assets/images/banner_tow.png',
            'assets/images/banner_three.png',
          ].map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // How much the shadow will spread
                        blurRadius: 6, // The blur radius of the shadow
                        offset: Offset(0, 3), // The position of the shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust margin to create space between items
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0), // Match the container's border radius
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
