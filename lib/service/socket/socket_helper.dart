import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/driver_details.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../utils/eve.dart';

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
    // _socket.on('findDriverResult', (data) {
    //   final response = jsonDecode(data);
    //   final driverDetails = DriverDetails.fromJson(response);
    //   print('Driver found: $response');
    //
    //   // Add driver details to the stream
    //   _driverDetailsController.add(driverDetails);
    // });
    listenToFindDriverResult();
  }

  void findDriver(String vehicleTypeId, String userId) {
    if (isConnected) {
      // Create the JSON object

      // Map<String, dynamic> joinData = {
      //   "vehicle_type_id": vehicleTypeId,
      //   "user_id": userId,
      // };
      //
      // String requestData = json.encode(joinData);

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

  // void listenToFindDriverResult() {
  //   print('listenToFindDriverResult: yes');
  //
  //   _socket.on('findDriverResult', (data) {
  //     print("data===${data}");
  //     try {
  //       final decodedData = data is String ? json.decode(data) : data;
  //       var driver_name = decodedData["driver_name"];
  //       var drop_address = decodedData["drop_address"];
  //       print('driver_name=====: $driver_name  $drop_address');
  //       final response = jsonDecode(data);
  //       final driverDetails = DriverDetails.fromJson(response);
  //       print('Driver found: $response');
  //
  //       // Add driver details to the stream
  //       _driverDetailsController.add(driverDetails);
  //       if (response.status == 'success') {
  //         print('Driver status: $response');
  //         _socket.disconnect();
  //
  //       }
  //     } catch (e) {
  //       debugPrint(' Driver Error processing message: ${e.toString()}');
  //     }
  //   });
  // }
  void listenToFindDriverResult() {
    print('Listening to findDriverResult...');

    _socket.on('findDriverResult', (data) {
      print("Received data: $data");
      requestStatus=true;
      print("requestStatus==$requestStatus");
      try {
        // Decode data only if it's a String; if it's already a Map, use it directly
        final decodedData = data is Map<String, dynamic> ? data : json.decode(data);

        // Populate the DriverDetails model from the decoded data
        final driverDetails = DriverDetails.fromJson(decodedData);
        print('Driver found: $driverDetails');

        // Add driver details to the stream for subscribers
        _driverDetailsController.add(driverDetails);

        // Additional logic based on response status
        if (driverDetails.status == 'success') {
         // confirmOrRejectRequest(reqId: driverDetails.sendRequestId, isConfirm: '1', isReject: '0');
          print('Driver found successfully');
         // _socket.disconnect();
        }
      } catch (e) {
        debugPrint('Driver Error processing message: ${e.toString()}');
      }
    });
  }

  void confirmOrRejectRequest({
    required String reqId,
    required String isConfirm,
    required String isReject,
  }) {
    // Create the JSON object
    final Map<String, dynamic> jsonData = {
      "req_id": reqId,
      "is_confirm": isConfirm,
      "is_reject": isReject,
    };

    // Emit the event to the WebSocket
    _socket.emit("updateBookingConfirm", jsonEncode(jsonData));

    // Log the emitted data for debugging
    print("confirmOrRejectRequest: ${jsonEncode(jsonData)}");


  }



  void disconnect() {
    if (isConnected) {
      _socket.disconnect();
      _driverDetailsController.close(); // Close the stream when disconnecting
      print("Socket disconnected.");
    }
  }


}