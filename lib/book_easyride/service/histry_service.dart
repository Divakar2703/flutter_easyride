// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../model/triphistry.dart';

// class ApiService {
//   final baseUrl = "https://asatvindia.in/cab/Api/User";

//   Future<TripHistryModel?> fetchTripHistory() async {
//     final url = Uri.parse("$baseUrl/trip_history_details");

//     String basicAuth = 'Basic ' +
//         base64Encode(utf8.encode('cabadmin:060789c53dd8c490b0e4695ba678f1a0'));

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": basicAuth,
//         },
//         body: jsonEncode({
//           "user_id": 6,
//           "pageno": 1,
//           "daterange": ""
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print("Response data: $data");
//         return TripHistryModel.fromJson(data);
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
