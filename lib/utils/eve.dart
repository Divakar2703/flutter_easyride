import 'package:flutter_easy_ride/model/vehicle_data.dart';

double ALatitude=24.854975080601193;
double ALongitude=74.61296919531905;
String address="Tilak Nagar  Senthri East Chittorgarh, Rajasthan 312025";
double dropLat=24.864073155095173;
double dropLong=74.61747914326327;
String dropAddress="MadhubanChittorgarh, Rajasthan";
String cabType="";
String selectedVehicle="";
String? selectedBank;
String bookingID="";
String orderID="";
String selectedPaymentMethod="COD";
Vehicle? vehicleDetails;
String BookingType="book_now";
double selectedFare=0.0;


final List<Map<String, dynamic>> banks = [
  {'name': 'GPay', 'image': 'assets/images/gpay.jpg'},
  {'name': 'Paytm', 'image': 'assets/images/paytem.png'},
  {'name': 'Online', 'image': 'assets/images/phonepay.png'},
  {'name': 'RozaPay', 'image': 'assets/images/rojapay.png'},
];
