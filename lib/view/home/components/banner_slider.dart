// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// class BannerSlider extends StatelessWidget {
//   String image;
//   String link;
//    BannerSlider({Key? key,required this.image,required this.link}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.0), // Adjust border radius as needed
//       ),
//       padding: EdgeInsets.all(8.0), // Adjust padding as needed
//       child: SizedBox(
//         width: double.infinity,
//         height: 180,
//         child: CarouselSlider(
//           options: CarouselOptions(
//             initialPage: 0, // Start from the first card
//             viewportFraction: 0.9,
//             enableInfiniteScroll: true,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 3),
//           ),
//           items: [
//             'assets/images/banner_one.png',
//             'assets/images/banner_tow.png',
//             'assets/images/banner_three.png',
//           ].map((item) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2), // Shadow color
//                         spreadRadius: 2, // How much the shadow will spread
//                         blurRadius: 6, // The blur radius of the shadow
//                         offset: Offset(0, 3), // The position of the shadow
//                       ),
//                     ],
//                   ),
//                   margin: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust margin to create space between items
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16.0), // Match the container's border radius
//                     child: Image.asset(
//                       item,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }




import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/dashboard.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerItem> banners; // List of banner image URLs or asset paths

  BannerSlider({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0), // Adjust border radius as needed
      ),
      padding: const EdgeInsets.all(8.0), // Adjust padding as needed
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
          items: banners.map((banner) {
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
                        offset: const Offset(0, 3), // The position of the shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust margin to create space between items
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0), // Match the container's border radius
                    child: Image.network(
                      banner.appBannerImage, // Use the dynamic banner URL or asset
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text("Image not available")); // Fallback for errors
                      },
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
