import 'dart:convert';
import 'package:web_socket_client/web_socket_client.dart';

import '../../model/driver_details.dart';

class DriverWebSocketService {
  final String url = 'wss://asatvindia.in:5001';
  late final WebSocket _webSocket;
  late Stream<DriverDetails> driverDetailsStream;

  DriverWebSocketService() {
    // Initialize WebSocket
    _webSocket = WebSocket(Uri.parse(url));

    // Listen to incoming messages and parse them into DriverDetails objects
    driverDetailsStream = _webSocket.messages.map((message) {
      print("msg===${message}");
      return DriverDetails.fromJson(jsonDecode(message));
    });
  }

  void findDriver(int vehicleTypeId, int userId) {
    final requestData = {
      "vehicle_type_id": vehicleTypeId,
      "user_id": userId,
    };
    _webSocket.send(jsonEncode(requestData));
    print("Sent request: $requestData");
  }

  void disconnect() {
    _webSocket.close();
  }
}

