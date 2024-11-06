import 'dart:convert';
import 'package:flutter/material.dart';
import '../../service/api_helper.dart';
import '../../service/network_utility.dart';
import '../model/triphistry.dart';
import 'package:http/http.dart' as http;






// ======  you remove this code because  triphistory and triphistory details so in triphistoryprovider. dart file 


// class TripHistoryProviders with ChangeNotifier {
//   List<TripHistory>? _tripHistoryList = [];
//   List<TripHistory>? get tripHistoryList => _tripHistoryList;

//   Future<void> fetchTripHistory(
//       int userId, int pageNo, String dateRange) async {
//     final url = Uri.parse('https://asatvindia.in/cab/Api/User/trip_history');
//     final headers = {
//       'Authorization': 'Basic ' +
//           base64Encode(
//               utf8.encode('cabadmin:060789c53dd8c490b0e4695ba678f1a0')),
//       'Content-Type': 'application/json',
//     };
//     final body = json.encode({
//       "user_id": userId,
//       "pageno": pageNo,
//       "daterange": dateRange,
//     });

//     notifyListeners();

//     try {
//       final response = await http.post(url, headers: headers, body: body);
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print("Response Data: ${response.body}");
//         print("Response Data: ${response.body}");
//         final List<dynamic> list = data['list'];
//         _tripHistoryList =
//             list.map((item) => TripHistory.fromJson(item)).toList();
//       } else {
//         print("Failed to fetch data. Status code: ${response.statusCode}");
//         _tripHistoryList = [];
//       }
//     } catch (error) {
//       print("Error fetching trip history: $error");
//       _tripHistoryList = [];
//     }

//     notifyListeners();
//   }
// }


//  updated code

  


class TriphistryProvider1 with ChangeNotifier {
  List<ListElement> historyList = [];

 Future<void> GetHistory() async {
    Map<String, dynamic> requestbody = {
      "user_id": 6,
      "pageno": 1,
      "daterange": ""
    };
    try {
      final response = await NetworkUtility.sendPostRequest(
          ApiHelper.triphistry, requestbody);
      Map<String, dynamic> json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        History history = History.fromJson(json);
        historyList = history.list;
        notifyListeners();
      } else {
        print('Failed to  load data');
      }
    } catch (Error) {
      print('not featch data please do correct code');
    }
  }
}
