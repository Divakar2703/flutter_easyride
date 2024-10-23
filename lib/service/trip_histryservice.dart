import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://asatvindia.in/cab/Api/User/trip_history";

  Future<List<dynamic>> getTripHistory(String userId) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'user_id': userId,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load trip history');
    }
  }
}
