import 'dart:convert';

import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';



class LocationUtils {
  static var searchAutocompleteUrl = "https://places.googleapis.com/v1/places:autocomplete?input=";
  static var placeDetailUrl = "https://places.googleapis.com/v1/places/";

  static Future<Map<String, dynamic>> searchPlaces(String input) async {
    String storedToken = await
        LocalStorage.getString('storedPlaceToken') ?? "";
    String sessionToken =
        storedToken.isNotEmpty ? storedToken : await saveAddressSessionToken();
    String apiKey = "AIzaSyAKgqAyTO5G0rIf8laUc5_gOaF16Qwjg2Y";

    String url = '${searchAutocompleteUrl}$input&session_token=$sessionToken&key=$apiKey';
    print("url===$url");

    final response = await http.post(Uri.parse(url));

    print("response===${response.body}");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Error in fetching auto complete predection");
      throw Exception('Failed to load predictions');
    }
  }

  static Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    String url =
        '${placeDetailUrl}$placeId?fields=formattedAddress,location&key=AIzaSyAKgqAyTO5G0rIf8laUc5_gOaF16Qwjg2Y';
print("url===${url}");
    final response = await http.get(Uri.parse(url));
print("response===${response.body}");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Error in fetching place details");
      throw Exception('Failed to load place details');
    }
  }

  static Future<String> saveAddressSessionToken() async {
    var uniqueSessionToken = Uuid().v4();
    await LocalStorage.saveString(
        "storedPlaceToken", uniqueSessionToken);
    return uniqueSessionToken;
  }

  static Future<Position?> getCurrentLocation() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      // Try to get the last known position first
      Position? lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) {
        // If the last known position is available, use it to reduce latency
        return lastPosition;
      }

      // If no last known position, get the current position with medium accuracy
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        // Change to medium for faster response
        timeLimit:
            Duration(seconds: 10), // Optional: set a time limit to speed up
      );

      return position;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  static Future<Placemark?> getAddFromLatLong(
      double latitude, double longitude) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placeMarks.isNotEmpty) {
        Placemark placeMark = placeMarks.first;

        return placeMark;
      } else {
        print('address not found');
        return null;
      }
    } catch (e) {
      print('Error retrieving address: $e');
      return null;
    }
  }

  static String getCompleteAddress(Placemark placeMark) {
    String completeAddress = [
      placeMark.street,
      placeMark.subLocality,
      placeMark.locality,
      placeMark.subAdministrativeArea,
      placeMark.administrativeArea,
      placeMark.country,
      placeMark.postalCode
    ].where((part) => part != null && part.isNotEmpty).join(', ');
    return completeAddress;
  }

}
