import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../model/driver_details.dart';

class WebSocketService {
  final String url = 'wss://asatvindia.in:5001';
  late WebSocketChannel _channel;

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    print("Connected to WebSocket: $url");
  }

  void disconnect() {
    _channel.sink.close();
  }

  void findDriver(int vehicleTypeId, int userId) {
    final requestData = {
      "vehicle_type_id": vehicleTypeId,
      "user_id": userId,
    };

    print("req===${requestData}");
    _channel.sink.add(jsonEncode(requestData));
  }

  Stream<DriverDetails> get driverDetailsStream {
    return _channel.stream.map((message) {
      final Map<String, dynamic> data = jsonDecode(message);
      print("data===${data}");
      return DriverDetails.fromJson(data);
    });
  }

  void dispose() {
    _channel.sink.close();
  }
}
