import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/vehicle_data.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/view/car_selection/models/save_ride_model.dart';
import 'package:flutter_easy_ride/view/car_selection/service/car_selection_service.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/payments/models/payment_gateway_model.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class CarSelectionProvider with ChangeNotifier {
  final service = CarSelectionService();
  List<VehicleList> vehicleList = [];
  VehicleResponse? vehicleModel;
  SaveRideModel? saveRideModel;

  bool loading = false;

  carSelection(int i) {
    vehicleList.forEach((e) => e..isSelected = false);
    vehicleList[i].isSelected = true;
    notifyListeners();
  }

  getVehicles(List<LatLng> latLang) async {
    List<Map<String, double>> list = [];
    try {
      loading = true;
      notifyListeners();
      latLang.forEach((e) => list.add({"lat": e.latitude, "long": e.longitude}));

      final userId = await LocalStorage.getId();
      final resp = await service.getVehicles({"waypoints": list, "user_id": userId});
      if (resp != null) {
        vehicleModel = resp;
        vehicleList = resp.data?.vehicleList ?? [];
      }
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
    }
  }

  PaymentGatewayDataModel? selectedPaymentMethod;

  changePaymentMode(PaymentGatewayDataModel value) {
    selectedPaymentMethod = value;
    notifyListeners();
  }

  List<PaymentGatewayDataModel> paymentTypeList = [
    PaymentGatewayDataModel(name: "COD", value: "cod", icon: AppImage.wallet),
    PaymentGatewayDataModel(name: "Wallet", value: "wallet", icon: AppImage.wallet),
  ];

  bool load = false;

  bookNow(
    List<LatLng> latLang,
    List<CommonTextField> locationTextfieldList,
    int selectedIndex,
  ) async {
    List<Map<String, dynamic>> list = [];
    try {
      load = true;
      notifyListeners();
      final userId = await LocalStorage.getId();

      for (int i = 0; i < locationTextfieldList.length; i++) {
        list.add({
          "lat": latLang[i].latitude,
          "long": latLang[i].longitude,
          "address": locationTextfieldList[i].con?.text ?? ""
        });
      }
      final selectedVehicle = vehicleList.firstWhere((e) => e.isSelected);
      final request = {
        "waypoints": list,
        "user_id": userId,
        "payment_mode": selectedPaymentMethod?.value ?? "cod",
        "vehicle_type_id": selectedVehicle.id,
        "booking_type": selectedIndex == 0
            ? "book_now"
            : selectedIndex == 1
                ? "pre_booking"
                : "rental",
        "added_by_web": "http://www.bits.teamtest.co.in"
      };
      final resp = await service.bookNow(request);
      if (resp != null) {
        saveRideModel = resp;
      }
      load = false;
      notifyListeners();
    } catch (e) {
      load = false;
      notifyListeners();
    }
  }
}
