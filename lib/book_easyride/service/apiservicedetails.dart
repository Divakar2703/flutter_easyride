// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/trip_histry_details_model.dart';

// class ApiServices {
//   final String _baseUrl =
//       "https://asatvindia.in/cab/Api/User/trip_history_details";

//   Future<TripHistryDetailsModel?> fetchTripHistoryDetails(
//       String bookingId) async {
//     final url = Uri.parse("$_baseUrl/trip_history_details");

//     String basicAuth = 'Basic ' +
//         base64Encode(utf8.encode('cabadmin:060789c53dd8c490b0e4695ba678f1a0'));
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": basicAuth,
//         },
//         body: jsonEncode({"booking_id": bookingId}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print(data);
//         return TripHistryDetailsModel.fromJson(data);
//       } else {
//         print("Failed to fetch data with status: ${response.statusCode}");
//         return null;
//       }
//     } catch (error) {
//       print("Error in ApiService: $error");
//       return null;
//     }
//   }
// }
