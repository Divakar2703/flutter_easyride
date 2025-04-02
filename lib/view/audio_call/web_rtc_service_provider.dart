import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/main.dart';
import 'package:flutter_easy_ride/view/audio_call/call_ui.dart';
import 'package:flutter_easy_ride/view/driver_details/ui/driver_detail_screen.dart';
import 'package:flutter_easy_ride/view/home/ui/bottom_bar_screen.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart' as getX;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../utils/constant.dart';
import '../driver_details/model/driver_details.dart';

class WebRTCProvider with ChangeNotifier {
  late IO.Socket socket;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  bool isCallActive = false;
  String? incomingCallerId;
  String? userId;
  bool isMicMuted = false;
  bool isSpeakerOn = false;
  Logger logger = Logger();
  double? driverLat;
  double? driverLong;
  DriverDetailsModel? driverDetailsModel;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  LatLng? currentLocation;
  List<LatLng> polylineCoordinates = [];

  List<String> _reasons = [
    "Selected Wrong Pickup Location",
    "Selected Wrong Drop Location",
    "Booked by mistake",
    "Selected different service/vehicle",
    "Taking too long to confirm the ride",
    "Got a ride elsewhere",
    "Others"
  ];

  String? _selectedReason;

  List<String> get reasons => _reasons;
  String? get selectedReason => _selectedReason;

  void selectReason(String reason) {
    _selectedReason = reason;
    notifyListeners(); // Notifies the UI about changes
  }

  Future<void> initSocket(String id) async {
    socket = IO.io(
      'https://cabsocket.asatvindia.in:5005',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setReconnectionAttempts(5)
          .build(),
    );
    userId = id;
    socket.connect();

    socket.onConnect((_) {
      print('✅ Connected to signaling server');
      socket.emit('register', userId);
    });

    socket.onDisconnect((_) => logger.i("Socket Disconnected"));

    socket.on('incoming_call', (data) async {
      print("📞 Incoming call from: ${data['fromUserId']}");
      incomingCallerId = data['fromUserId'];
      notifyListeners();

      if (_peerConnection == null) {
        print("❌ Peer connection is not initialized! Initializing now...");
        await _initializePeerConnection();
      }

      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(data['offer']['sdp'], data['offer']['type']),
      );

      getX.Get.defaultDialog(
        title: "Incoming Call",
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.call, size: 50, color: Colors.green),
            SizedBox(height: 10),
            Text("Call from: $incomingCallerId"),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                rejectCall();
                getX.Get.back();
              },
              child: Text("Reject", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                getX.Get.back();
                await acceptCall();
                getX.Get.to(() => CallUi());
              },
              child: Text("Accept"),
            ),
          ],
        ),
      );
    });

    socket.on('call_answered', (data) async {
      print("✅ Call answered");
      if (_peerConnection != null) {
        await _peerConnection!.setRemoteDescription(
          RTCSessionDescription(data['answer']['sdp'], data['answer']['type']),
        );
      }
      isCallActive = true;
      notifyListeners();
    });

    socket.on('ice_candidate', (data) async {
      print("❄️ Received ICE candidate");
      if (_peerConnection != null && data['candidate'] != null) {
        try {
          await _peerConnection!.addCandidate(RTCIceCandidate(
            data['candidate']['candidate'],
            data['candidate']['sdpMid'] ?? "",
            data['candidate']['sdpMLineIndex'] ?? 0,
          ));
        } catch (e) {
          print("⚠️ Error adding ICE candidate: $e");
        }
      }
    });

    ///driver details listening
    socket.on('ride_accepted', (data) async {
      driverDetailsModel = DriverDetailsModel.fromJson(data);

      markers.add(
        Marker(
          markerId: MarkerId("source"),
          position: LatLng(driverDetailsModel?.waypoints?.first.lat ?? 0.0,
              driverDetailsModel?.waypoints?.first.long ?? 0.0),
          icon: await BitmapDescriptor.asset(
            ImageConfiguration(size: Size(10, 10)),
            AppImage.source,
          ),
        ),
      );

      notifyListeners();
      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => DriverDetailScreen()),
      );
    });

    socket.on("update_location", (data) => _updateDriverLocation(data));
    _initializePeerConnection();
  }

  _updateDriverLocation(data) {
    driverLat = data["latitude"];
    driverLong = data["longitude"];

    addPolyLine(driverLat: driverLat, driverLong: driverLong, isPickup: true);
    addMarkers(
        driverLat: driverLat,
        driverLong: driverLong,
        waypoints: driverDetailsModel?.waypoints,
        isPickup: true);
    notifyListeners();
  }

  addPolyLine({double? driverLat, double? driverLong, bool? isPickup}) async {
    if (isPickup ?? false) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: googleApiKey,
          request: PolylineRequest(
              origin: PointLatLng(driverLat ?? 0.0, driverLong ?? 0.0),
              destination: PointLatLng(
                  driverDetailsModel?.waypoints?.first.lat ?? 0.0,
                  driverDetailsModel?.waypoints?.first.long ?? 0.0),
              mode: TravelMode.driving));

      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        notifyListeners();
      }
    }
  }

  addMarkers(
      {double? driverLat,
      double? driverLong,
      List<Waypoints>? waypoints,
      bool? isPickup}) async {
    if (isPickup ?? false) {
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        LatLng nextPosition = polylineCoordinates[i + 1];
        double bearing = calculateBearing(polylineCoordinates[i], nextPosition);

        markers.add(
          Marker(
              markerId: MarkerId("driver_id"),
              position: LatLng(driverLat ?? 0.0, driverLong ?? 0.0),
              icon: await BitmapDescriptor.asset(
                  ImageConfiguration(size: Size(40, 40)),
                  driverDetailsModel?.type?.toLowerCase() == "car"
                      ? AppImage.carMap
                      : driverDetailsModel?.type?.toLowerCase() == "auto"
                          ? AppImage.autoMap
                          : driverDetailsModel?.type?.toLowerCase() == "bike"
                              ? AppImage.bikeMap
                              : ""),
              rotation: bearing),
        );

        await Future.delayed(Duration(seconds: 1)); // Simulate movement delay
      }
    }
  }

  disConnectSocket() {
    socket.disconnect();
  }

  Future<void> callUser(String toUserId) async {
    try {
      RTCSessionDescription offer = await _peerConnection!.createOffer();
      await _peerConnection!.setLocalDescription(offer);
      await Future.delayed(Duration(milliseconds: 500));
      socket.emit('call_user', {
        'fromUserId': userId,
        'toUserId': toUserId,
        'offer': offer.toMap(),
      });
    } catch (e) {
      print("⚠️ Error calling user: $e");
    }
  }

  void rejectCall() {
    if (incomingCallerId != null) {
      socket.emit('call_rejected', {'toUserId': incomingCallerId});
    }
    incomingCallerId = null;
    notifyListeners();
  }

  Future<void> requestPermissions() async {
    var status = await Permission.microphone.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      print("❌ Microphone permission denied");
      return;
    }
  }

  void enableSpeakerphone() {
    isSpeakerOn = true;
    Helper.setSpeakerphoneOn(true);
    notifyListeners();
  }

  void toggleSpeaker() {
    isSpeakerOn = !isSpeakerOn;
    Helper.setSpeakerphoneOn(isSpeakerOn);
    notifyListeners();
    print("🔊 Speaker ${isSpeakerOn ? 'On' : 'Off'}");
  }

  void toggleMic() {
    if (_localStream != null) {
      bool enabled = _localStream!.getAudioTracks().first.enabled;
      _localStream!.getAudioTracks().first.enabled = !enabled;
      isMicMuted = !enabled;
      notifyListeners();
      print("🎤 Mic ${isMicMuted ? 'Muted' : 'Unmuted'}");
    }
  }

  Future<void> _initializePeerConnection() async {
    await requestPermissions();
    _localStream = await navigator.mediaDevices
        .getUserMedia({'audio': true, 'video': false});
    _remoteStream = await createLocalMediaStream('remoteStream');

    _peerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': ['stun:stun1.l.google.com:19302']
        },
      ]
    }, {
      'mandatory': {
        'OfferToReceiveAudio': true,
      },
    });

    _localStream!.getTracks().forEach((track) {
      print("🎤 Adding track: ${track.kind}");
      _peerConnection!.addTrack(track, _localStream!);
    });

    _peerConnection!.onTrack = (RTCTrackEvent event) {
      print("🔊 Received track: ${event.track.kind}");
      if (event.track.kind == 'audio') {
        _remoteStream!.addTrack(event.track);
      }
    };

    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      print("📨 Sending ICE candidate");
      socket.emit('ice_candidate', {
        'toUserId': incomingCallerId ?? userId,
        'candidate': candidate.toMap(),
      });
    };
  }

  Future<void> acceptCall() async {
    if (incomingCallerId == null) return;
    RTCSessionDescription answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);
    socket.emit('answer_call',
        {'toUserId': incomingCallerId, 'answer': answer.toMap()});
    isCallActive = true;
    incomingCallerId = null;
    notifyListeners();
  }

  void disposeService() {
    socket.disconnect();
    socket.dispose();
    _peerConnection?.close();
    _localStream?.dispose();
    _remoteStream?.dispose();
  }

  /// For Booking
  findDriver(String bookingId) {
    socket.emit("find_driver", {"booking_id": bookingId});
  }

  ///marker and polyline for driver details

  final String googleApiKey = "AIzaSyCqOtn--DWaSee5PMjb1J1zkPe7gw5XMWQ";

  Future<void> getPolyPoints(
      {double? pickupLat,
      double? pickupLong,
      double? destLat,
      double? destLng}) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: googleApiKey,
          request: PolylineRequest(
              origin: PointLatLng(pickupLat ?? 0.0, pickupLong ?? 0.0),
              destination: PointLatLng(destLat ?? 0.0, destLng ?? 0.0),
              mode: TravelMode.driving));

      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        notifyListeners();
      }
    } catch (error) {
      print("Error getting route: $error");
    }
  }

  double calculateBearing(LatLng start, LatLng end) {
    double lat1 = start.latitude * pi / 180;
    double lat2 = end.latitude * pi / 180;
    double lon1 = start.longitude * pi / 180;
    double lon2 = end.longitude * pi / 180;

    double deltaLon = lon2 - lon1;
    double y = sin(deltaLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(deltaLon);

    double bearing = atan2(y, x) * 180 / pi;
    return (bearing + 360) % 360; // Normalize angle
  }

  void updateMarkerPosition() async {}

  void cancelRideFromUser(String reason) {
    socket.emit('cancel_ride',
        {"booking_id": driverDetailsModel?.bookingId, "reason": reason});

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => BottomBarScreen()),
        (route) => false,
      );
    });

    notifyListeners();
  }
}
