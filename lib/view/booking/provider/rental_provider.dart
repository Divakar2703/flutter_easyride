import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/view/booking/models/common_model.dart';

class RentalProvider with ChangeNotifier {
  final kmList = [
    CommonModel(title: "1 Hr", subTitle: "10 km"),
    CommonModel(title: "2 Hr", subTitle: "20 km"),
    CommonModel(title: "3 Hr", subTitle: "30 km"),
    CommonModel(title: "4 Hr", subTitle: "40 km"),
    CommonModel(title: "5 Hr", subTitle: "50 km"),
    CommonModel(title: "6 Hr", subTitle: "60 km"),
    CommonModel(title: "7 Hr", subTitle: "70 km"),
  ];
}
