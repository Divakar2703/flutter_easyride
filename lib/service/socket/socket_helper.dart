import 'dart:convert';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:web_socket_client/web_socket_client.dart';
import '../../model/driver_details.dart';

// class WebSocketHelper {
//   static final WebSocketHelper _singleton = WebSocketHelper._internal();
//   final Duration _timeout;
//   final ConstantBackoff _backoff;
//   late WebSocket _socket;
//   bool isConnected = false;
//   late Uri _uri;
//   late Stream<DriverDetails> driverDetailsStream;
//
//   WebSocketHelper._internal()
//       : _timeout = const Duration(seconds: 10),
//         _backoff = const ConstantBackoff(Duration(seconds: 5)) {
//     _updateUri();
//   }
//
//   factory WebSocketHelper() => _singleton;
//
//   void _updateUri() {
//     _uri = Uri.parse('https://asatvindia.in:5001/');
//     print("Socket URL set to: $_uri");
//   }
//
//   WebSocket getSocket() => _socket;
//
//   Future<void> connect() async {
//     _updateUri();
//
//     try {
//       // Initialize the WebSocket connection
//       _socket = WebSocket(_uri, timeout: _timeout, backoff: _backoff);
//
//       // Listen for connection state changes
//       _socket.connection.listen((event) {
//         print("Connection state: $event");
//
//         if (event is Connected || event is Reconnected) {
//           isConnected = true;
//           print("WebSocket is connected.");
//         } else {
//           isConnected = false;
//           print("WebSocket is not connected. Current state: $event");
//         }
//       }, onError: (error) {
//         print("Error during connection: $error");
//       }, onDone: () {
//         print("Connection closed.");
//         isConnected = false;
//       });
//
//       // Listen for incoming messages and map to DriverDetails
//       driverDetailsStream = _socket.messages.map((message) {
//         print("Received message: $message");
//         return DriverDetails.fromJson(jsonDecode(message));
//       });
//
//     } catch (e) {
//       print("Failed to connect to WebSocket: $e");
//     }
//   }
//
//   void close([int? code, String? reason]) {
//     if (_socket.connection.state is! Disconnected) {
//       print("Closing WebSocket connection.");
//       isConnected = false;
//       _socket.close(code, reason);
//     }
//   }
//
//   void sendMessage(Map<String, dynamic> map) {
//     if (isConnected) {
//       print("Sending message: ${jsonEncode(map)}");
//       _socket.send(jsonEncode(map));
//     } else {
//       print("Cannot send message, WebSocket is not connected.");
//     }
//   }
//
//   void findDriver(String vehicleTypeId, String userId) {
//     final requestData = {
//       "vehicle_type_id": vehicleTypeId,
//       "user_id": userId,
//     };
//     sendMessage(requestData);
//   }
//
//   void handleResponse(Map<String, dynamic> response) {
//     print("Response from WebSocket: $response");
//     // Process the response
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../model/driver_details.dart';

class SocketHelper {
  static final SocketHelper _instance = SocketHelper._internal();
  late IO.Socket _socket;
  bool isConnected = false;

  // StreamController for DriverDetails data
  final StreamController<DriverDetails> _driverDetailsController = StreamController.broadcast();
  Stream<DriverDetails> get driverDetailsStream => _driverDetailsController.stream;

  // Private constructor for singleton pattern
  SocketHelper._internal();

  factory SocketHelper() {
    return _instance;
  }

  void connect() {
    // Initialize the socket connection
    _socket = IO.io('https://asatvindia.in:5001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    // Connect the socket and handle events
    _socket.connect();

    // Listen for connection events
    _socket.onConnect((_) {
      isConnected = true;
      print('Socket connected');
    });

    _socket.onDisconnect((_) {
      isConnected = false;
      print('Socket disconnected');
    });

    _socket.onError((error) {
      print('Socket error: $error');
    });

    _socket.onReconnect((_) {
      print('Socket reconnected');
    });

    // Listen for the 'driver_found' event from the server
    _socket.on('driver_found', (data) {
      final response = jsonDecode(data);
      final driverDetails = DriverDetails.fromJson(response);
      print('Driver found: $response');

      // Add driver details to the stream
      _driverDetailsController.add(driverDetails);
    });
  }

  void findDriver(String vehicleTypeId, String userId) {
    if (isConnected) {
      // Create the JSON object
      final requestData = {
        "vehicle_type_id": vehicleTypeId,
        "user_id": userId,
      };

      // Emit the event named 'findDriver' with request data
      print("Sending findDriver request: $requestData");
      _socket.emit("findDriver", jsonEncode(requestData));
    } else {
      print("Cannot send request, socket not connected");
    }
  }

  void disconnect() {
    if (isConnected) {
      _socket.disconnect();
      _driverDetailsController.close(); // Close the stream when disconnecting
      print("Socket disconnected.");
    }
  }
}

