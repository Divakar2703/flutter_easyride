import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/location_suggetions.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/utils/toast.dart';
import 'package:flutter_easy_ride/view/booking/models/common_model.dart';
import 'package:flutter_easy_ride/view/profile/models/address_model.dart';
import 'package:flutter_easy_ride/view/profile/models/profile_model.dart';
import 'package:flutter_easy_ride/view/profile/services/profile_service.dart';
import 'package:geocoding/geocoding.dart';

class ProfileProvider extends ChangeNotifier {
  final profileService = ProfileService();
  ProfileDataModel? profileDataModel;
  bool load = false;
  bool loadAddress = false;
  List<AddressDataModel> addressList = [];

  List<CommonModel> addressTypeList = [
    CommonModel(image: AppImage.homeSvg, title: "Home", isSelected: true),
    CommonModel(image: AppImage.officeSvg, title: "Office", isSelected: false),
    CommonModel(image: AppImage.location, title: "Other", isSelected: false),
  ];

  changeAddressType(int i) {
    addressTypeList.forEach((e) => e.isSelected = false);
    addressTypeList[i].isSelected = true;
    notifyListeners();
  }

  updateList() {
    placesList.clear();
    notifyListeners();
  }

  getProfile() async {
    try {
      load = true;
      notifyListeners();
      final userId = await LocalStorage.getId();
      final resp = await profileService.getProfile(userId: userId);
      if (resp != null) {
        if (resp.data != null) {
          profileDataModel = resp.data!;
        }
      }
      load = false;
      notifyListeners();
    } catch (e) {
      load = false;
      notifyListeners();
    }
  }

  updateProfile({String? name, String? email, int? phone}) async {
    try {
      final userId = await LocalStorage.getId();
      final resp = await profileService.updateProfile(userId: userId, phone: phone, name: name, email: email);
      if (resp != null) {
        AppUtils.show(resp.message ?? "");
        getProfile();
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  getSavedAddress() async {
    try {
      addressList.clear();
      loadAddress = true;
      final userId = await LocalStorage.getId();
      final resp = await profileService.getSavedAddress(userId: userId);
      if (resp != null) {
        if (resp.data != null) {
          addressList = resp.data ?? [];
        }
      }
      loadAddress = false;
      notifyListeners();
    } catch (e) {
      loadAddress = false;
      notifyListeners();
    }
  }

  addAddress({String? address}) async {
    try {
      final userId = await LocalStorage.getId();
      final latLng = await locationFromAddress(address ?? "");
      final resp = await profileService.addAddress(
          userId: userId,
          type: addressTypeList.firstWhere((e) => e.isSelected ?? false).title,
          address: address,
          latLng: latLng[0]);
      if (resp != null) {
        AppUtils.show(resp.message ?? "");
        getSavedAddress();
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  deleteAddress({int? id}) async {
    try {
      final userId = await LocalStorage.getId();
      final resp = await profileService.deleteAddress(userId: userId, id: id);
      if (resp != null) {
        AppUtils.show(resp.message ?? "");
        getSavedAddress();
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  List<Suggestions> placesList = [];
  searchLocation(String v) async {
    placesList.clear();
    try {
      final resp = await profileService.searchLocation(v: v);
      if (resp != null) {
        placesList = resp.suggestions ?? [];
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
