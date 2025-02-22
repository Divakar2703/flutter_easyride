import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easy_ride/utils/eve.dart';

import '../../../service/api_helper.dart';
import '../../../service/network_utility.dart';
import '../models/notification_response.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission (iOS only)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User denied or has not granted permission');
    }

    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');
    });
  }

  Future<List<Notifications>> fetchNotifications(int page, int limit) async {
    Map<String, dynamic> requestBody = {
      "user_id": userID,
      "type": "ridecomplete", //search_payment,ridecomplete,cabrequest
      "paymenttype": "online", //cod,online
      "pageno": page
    };
    print("req===${requestBody}");
    final response = await NetworkUtility.sendPostRequest(ApiHelper.notification_history, requestBody);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      NotificationResponse notificationResponse = NotificationResponse.fromJson(jsonResponse);
      return notificationResponse.list;
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}
