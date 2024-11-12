import 'dart:convert';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:web_socket_client/web_socket_client.dart';
import '../../model/driver_details.dart';

class WebSocketHelper {
  static final WebSocketHelper _singleton = WebSocketHelper._internal();
  final Duration _timeout;
  final ConstantBackoff _backoff;
  late WebSocket _socket;
  bool isConnected = false;
  late Uri _uri;
  late Stream<DriverDetails> driverDetailsStream;

  WebSocketHelper._internal()
      : _timeout = const Duration(seconds: 10),
        _backoff = const ConstantBackoff(Duration(seconds: 5)) {
    _updateUri();
  }

  factory WebSocketHelper() => _singleton;

  void _updateUri() {
    _uri = Uri.parse('https://asatvindia.in:5001/');
    print("Socket URL set to: $_uri");
  }

  WebSocket getSocket() => _socket;

  Future<void> connect() async {
    _updateUri();

    try {
      // Initialize the WebSocket connection
      _socket = WebSocket(_uri, timeout: _timeout, backoff: _backoff);

      // Listen for connection state changes
      _socket.connection.listen((event) {
        print("Connection state: $event");

        if (event is Connected || event is Reconnected) {
          isConnected = true;
          print("WebSocket is connected.");
        } else {
          isConnected = false;
          print("WebSocket is not connected. Current state: $event");
        }
      }, onError: (error) {
        print("Error during connection: $error");
      }, onDone: () {
        print("Connection closed.");
        isConnected = false;
      });

      // Listen for incoming messages and map to DriverDetails
      driverDetailsStream = _socket.messages.map((message) {
        print("Received message: $message");
        return DriverDetails.fromJson(jsonDecode(message));
      });

    } catch (e) {
      print("Failed to connect to WebSocket: $e");
    }
  }

  void close([int? code, String? reason]) {
    if (_socket.connection.state is! Disconnected) {
      print("Closing WebSocket connection.");
      isConnected = false;
      _socket.close(code, reason);
    }
  }

  void sendMessage(Map<String, dynamic> map) {
    if (isConnected) {
      print("Sending message: ${jsonEncode(map)}");
      _socket.send(jsonEncode(map));
    } else {
      print("Cannot send message, WebSocket is not connected.");
    }
  }

  void findDriver(String vehicleTypeId, String userId) {
    final requestData = {
      "vehicle_type_id": vehicleTypeId,
      "user_id": userId,
    };
    sendMessage(requestData);
  }

  void handleResponse(Map<String, dynamic> response) {
    print("Response from WebSocket: $response");
    // Process the response
  }
}
