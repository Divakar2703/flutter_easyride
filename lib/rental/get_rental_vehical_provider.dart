import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import '../../service/api_helper.dart';

class RentalVehicle {
  final String id;
  final String name;
  final String image;
  final String description;
  final String type;
  final String promocodeStatus;
  final double fare;
  final String discount;
  final double netFare;
  final int km;

  RentalVehicle({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.type,
    required this.promocodeStatus,
    required this.fare,
    required this.discount,
    required this.netFare,
    required this.km,
  });

  factory RentalVehicle.fromJson(Map<String, dynamic> json) {
    return RentalVehicle(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      type: json['type'],
      promocodeStatus: json['promocode_status'],
      fare: json['fare'].toDouble(),
      discount: json['discount'],
      netFare: json['net_fare'].toDouble(),
      km: json['km'],
    );
  }
}

class GetRentalVehicleResponse {
  final List<RentalVehicle> vehicles;
  final String status;
  final String message;
  final int statusCode;

  GetRentalVehicleResponse({
    required this.vehicles,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  factory GetRentalVehicleResponse.fromJson(Map<String, dynamic> json) {
    var vehiclesJson = json['vehicle'] as List;
    List<RentalVehicle> vehiclesList = vehiclesJson
        .map((vehicleJson) => RentalVehicle.fromJson(vehicleJson))
        .toList();

    return GetRentalVehicleResponse(
      vehicles: vehiclesList,
      status: json['status'],
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}

class GetRentalVehicleProvider with ChangeNotifier {
  GetRentalVehicleResponse? getRentalVehicleResponse;

  Future<void> getRentalVehicle(double pickupLat, double pickupLong, int hours, int kms) async {
    try {
      final response = await NetworkUtility.sendPostRequest(
        ApiHelper.getRentalVehicle,
        {
          "pickup_lat": pickupLat,
          "pickup_long": pickupLong,
          "hours": hours,
          "kms": kms,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        getRentalVehicleResponse = GetRentalVehicleResponse.fromJson(jsonResponse);
      } else {
        print('Error fetching rental vehicles: ${response.statusCode}');
        getRentalVehicleResponse = null;
      }
    } catch (e) {
      print('Error making API request: $e');
      getRentalVehicleResponse = null;
    }

    notifyListeners();
  }
}
