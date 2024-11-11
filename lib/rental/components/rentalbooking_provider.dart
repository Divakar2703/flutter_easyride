import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import '../../service/api_helper.dart';

/// Rental Request Model
class RentalRequest {
  final double pickupLat;
  final double pickupLong;
  final String addedByWeb;
  final String pickupAddress;
  final String bookingType;
  final int userId;

  // Constructor for the request model
  RentalRequest({
    required this.pickupLat,
    required this.pickupLong,
    required this.addedByWeb,
    required this.pickupAddress,
    required this.bookingType,
    required this.userId,
  });

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'pickup_lat': pickupLat,
      'pickup_long': pickupLong,
      'added_by_web': addedByWeb,
      'pickup_address': pickupAddress,
      'booking_type': bookingType,
      'user_id': userId,
    };
  }
}

/// Rental Response Model
class RentalResponse {
  final List<int> km;
  final List<int> hr;
  final String status;
  final String message;
  final int statusCode;

  // Constructor for the response model
  RentalResponse({
    required this.km,
    required this.hr,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  // Factory constructor to create an object from JSON data
  factory RentalResponse.fromJson(Map<String, dynamic> json) {
    return RentalResponse(
      km: List<int>.from(json['package']['km']),
      hr: List<int>.from(json['package']['hr']),
      status: json['status'],
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}

class RentalbookingProvider with ChangeNotifier {
  RentalResponse? rentalResponse;

  /// Method to call the getRentalBooking API
  Future<void> getRentalBooking(
      double pickupLat,
      double pickupLong,
      String addedByWeb,
      String pickupAddress,
      String bookingType,
      int userId) async {
    // Create a RentalRequest object with required data
    var rentalRequest = RentalRequest(
      pickupLat: pickupLat,
      pickupLong: pickupLong,
      addedByWeb: addedByWeb,
      pickupAddress: pickupAddress,
      bookingType: bookingType,
      userId: userId,
    );

    try {
      // Sending the POST request with the JSON data from RentalRequest model
      final response = await NetworkUtility.sendPostRequest(
        ApiHelper.getRentalBooking,
        rentalRequest.toJson(),
      );

      // Check if response is successful
      if (response.statusCode == 200) {
        // Parsing response body into RentalResponse model
        var jsonResponse = jsonDecode(response.body);
        rentalResponse = RentalResponse.fromJson(jsonResponse);

        // Print parsed data for debugging
        print(rentalResponse!.km);
        print(rentalResponse!.hr);
        print('Response: ${response.body}');
      } else {
        print('Failed to fetch rental booking data');
      }
    } catch (error) {
      print('Error fetching rental booking data: $error');
    }
  }
}
