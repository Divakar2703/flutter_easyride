import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/car_selection/models/car_model.dart';

class CarSelectionProvider with ChangeNotifier {
  final carList = [
    CarModel(
        price: "₹270",
        title: "Mini",
        time: "18 min",
        image: AppImage.miniCar,
        subTitle: "Affordable rides for your everyday travel!"),
    CarModel(
        price: "₹320",
        title: "Micro",
        time: "18 min",
        image: AppImage.microCar,
        subTitle: "Budget-friendly and perfect for solo or duo trips!"),
    CarModel(
        price: "₹570",
        title: "Prime",
        time: "18 min",
        image: AppImage.primeCar,
        subTitle: "Luxury and comfort for your premium rides"),
    CarModel(
        price: "₹70",
        title: "Auto",
        time: "2 min",
        image: AppImage.auto,
        subTitle: "Pocket-friendly rides, anytime, anywhere!"),
    CarModel(
        price: "₹120",
        title: "Bike",
        time: "2 min",
        image: AppImage.bicycle,
        subTitle: "Affordable, fast, and hassle-free solo rides"),
  ];
}
