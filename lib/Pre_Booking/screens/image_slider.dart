import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';


class PreeVehicle extends StatefulWidget {
  const PreeVehicle({super.key});

  @override
  State<PreeVehicle> createState() => _PreeVehicleState();
}

class _PreeVehicleState extends State<PreeVehicle> {
  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.white,
      height: 100,
      autoPlayInterval: 1000,
      indicatorRadius: 0.1,
      isLoop: true,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/ride_car_one.png"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/ride_car_two.png"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/ride_car_one.png"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/ride_car_three.png"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/ride_car_one.png"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/ride_car_three.png"),
        ),
      ],
    );
  }
}
