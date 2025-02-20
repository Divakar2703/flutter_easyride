import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/models/common_model.dart';

class BookNowProvider with ChangeNotifier {
  final addList = [
    CommonModel(title: "Home", image: AppImage.home),
    CommonModel(title: "Office", image: AppImage.office),
    CommonModel(title: "Add New", image: AppImage.pluse),
  ];
}
