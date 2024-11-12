import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import '../../service/api_helper.dart';

/// Recurring Rental Request Model
// class RecurringRentalRequest {
//   final double pickupLat;
//   final double pickupLong;
//   final double dropLat;
//   final double dropLong;
//   final String addedByWeb;
//   final String pickupAddress;
//   final String dropAddress;
//   final String bookingType;
//   final int userId;
//
//   // Constructor for the request model
//   RecurringRentalRequest({
//     required this.pickupLat,
//     required this.pickupLong,
//     required this.dropLat,
//     required this.dropLong,
//     required this.addedByWeb,
//     required this.pickupAddress,
//     required this.dropAddress,
//     required this.bookingType,
//     required this.userId,
//   });
//
//   // Method to convert the object to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'pickup_lat': pickupLat,
//       'pickup_long': pickupLong,
//       'drop_lat': dropLat,
//       'drop_long': dropLong,
//       'added_by_web': addedByWeb,
//       'pickup_address': pickupAddress,
//       'drop_address': dropAddress,
//       'booking_type': bookingType,
//       'user_id': userId,
//     };
//   }
// }

/// Recurring Rental Response Model
class RecurringRentalResponse {
  final List<int> km;
  final List<int> hr;
  final double distance;
  final String status;
  final String message;
  final int statusCode;

  // Constructor for the response model
  RecurringRentalResponse({
    required this.km,
    required this.hr,
    required this.distance,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  // Factory constructor to create an object from JSON data
  factory RecurringRentalResponse.fromJson(Map<String, dynamic> json) {
    if (json == null || json['package'] == null) {
      throw Exception('Invalid response data: Missing package field');
    }

    try {
      return RecurringRentalResponse(
        km: List<int>.from(json['package']['km'] ?? []),
        hr: List<int>.from(json['package']['hr'] ?? []),
        distance: json['package']['distance']?.toDouble() ?? 0.0,
        status: json['status'] ?? '',
        message: json['message'] ?? '',
        statusCode: json['statusCode'] ?? 0,
      );
    } catch (e) {
      throw Exception('Error parsing response: $e');
    }
  }
}

class RecurringBookingProvider with ChangeNotifier {
  RecurringRentalResponse? recurringRentalResponse;

  /// Method to call the recurring rental booking API
  Future<void> getRecurringBooking(
      double pickupLat,
      double pickupLong,
      double dropLat,
      double dropLong,
      String addedByWeb,
      String pickupAddress,
      String dropAddress,
      String bookingType,
      int userId) async {
    // var recurringRequest = RecurringRentalRequest(
    //   pickupLat: pickupLat,
    //   pickupLong: pickupLong,
    //   dropLat: dropLat,
    //   dropLong: dropLong,
    //   addedByWeb: addedByWeb,
    //   pickupAddress: pickupAddress,
    //   dropAddress: dropAddress,
    //   bookingType: bookingType,
    //   userId: userId,
    // );
    print(
        "Recurring Booking Request:\n"
            "Pickup Latitude: $pickupLat\n"
            "Pickup Longitude: $pickupLong\n"
            "Drop Latitude: $dropLat\n"
            "Drop Longitude: $dropLong\n"
            "Added By Web: $addedByWeb\n"
            "Pickup Address: $pickupAddress\n"
            "Drop Address: $dropAddress\n"
            "Booking Type: $bookingType\n"
            "User ID: $userId"
    );
    try {
      // print("recurringRequest=======================${recurringRequest.addedByWeb}==${recurringRequest..pickupLat}");
      final response = await NetworkUtility.sendPostRequest(
        ApiHelper.getRecurringBooking,
        {
          'pickup_lat': pickupLat,
          'pickup_long': pickupLong,
          'drop_lat': dropLat,
          'drop_long': dropLong,
          'added_by_web': addedByWeb,
          'pickup_address': pickupAddress,
          'drop_address': dropAddress,
          'booking_type': bookingType,
          'user_id': userId,
        }

      );

      print('Response Body: ${response.body}');
      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          var jsonResponse = jsonDecode(response.body);

          // Debug the response body
          print('Parsed JSON rcurring: $jsonResponse');

          // Check if "package" field exists and parse accordingly
          if (jsonResponse['package'] == null) {
            throw Exception('Package data is missing from the response.');
          }

          recurringRentalResponse = RecurringRentalResponse.fromJson(jsonResponse);
          print('KM: ${recurringRentalResponse!.km}');
          print('HR: ${recurringRentalResponse!.hr}');
        } catch (e) {
          print('Error parsing data: $e');
          recurringRentalResponse = null;
        }
      } else {
        print('API Request failed: ${response.statusCode}');
        recurringRentalResponse = null;
      }
    } catch (error) {
      print('Error making API request: $error');
      recurringRentalResponse = null;
    }

    notifyListeners();  // Notify listeners that data has been updated
  }
}
