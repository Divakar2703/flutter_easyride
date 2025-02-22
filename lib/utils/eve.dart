import 'package:flutter_easy_ride/model/vehicle_data.dart';

double ALatitude = 24.854975080601193;
double ALongitude = 74.61296919531905;
String address = "Tilak Nagar  Senthri East Chittorgarh, Rajasthan 312025";
double dropLat = 24.864073155095173;
double dropLong = 74.61747914326327;
String dropAddress = "MadhubanChittorgarh, Rajasthan";
String cabType = "";
String selectedVehicle = "";
String bookingID = "";
String orderID = "";
String selectedBank = "COD";
Vehicle? vehicleDetails;
String BookingType = "book_now";
double selectedFare = 0.0;
String transactionID = "";
bool requestStatus = false;
String fToken = "";
String userID = "";

final List<Map<String, dynamic>> banks = [
  {'name': 'online', 'image': 'assets/images/gpay.jpg'},
  {'name': 'COD', 'image': 'assets/images/paytem.png'},
  {'name': 'phonepay', 'image': 'assets/images/phonepay.png'},
  {'name': 'razorpay', 'image': 'assets/images/rojapay.png'},
];
