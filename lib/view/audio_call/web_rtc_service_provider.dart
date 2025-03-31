import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/main.dart';
import 'package:flutter_easy_ride/view/audio_call/call_ui.dart';
import 'package:flutter_easy_ride/view/driver_details/ui/driver_detail_screen.dart';
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

  void initSocket(String id) {
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
    socket.on('ride_accepted', (data) {
      driverDetailsModel = DriverDetailsModel.fromJson(data);

      Navigator.push(navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => DriverDetailScreen()));
    });

    socket.on("update_location", (data) {
      driverLat = data["latitude"];
      driverLong = data["longitude"];
      loadMapData(
          pickupLat: driverLat ?? 0.0,
          pickupLong: driverDetailsModel?.waypoints?.first.long ?? 0.0,
          destLat: driverDetailsModel?.waypoints?.last.lat ?? 0.0,
          destLng: driverDetailsModel?.waypoints?.last.long ?? 0.0);
      getPolyPoints(
          pickupLat: driverDetailsModel?.waypoints?.first.lat ?? 0.0,
          pickupLong: driverDetailsModel?.waypoints?.first.long ?? 0.0,
          destLat: driverDetailsModel?.waypoints?.last.lat ?? 0.0,
          destLng: driverDetailsModel?.waypoints?.last.long ?? 0.0);
    });
    _initializePeerConnection();
  }

  addMarkers() {
    markers.add(
      Marker(
          markerId: markerId,
          position: l,
          icon: icon,
          anchor: Offset(0.5, 0.5),
          infoWindow: InfoWindow(title: address)),
    );
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

  void loadMapData(
      {double? pickupLat,
      double? pickupLong,
      double? destLat,
      double? destLng}) async {
    // Simulate a delay to fetch map data
    await Future.delayed(Duration(seconds: 2));
    final BitmapDescriptor pickupIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(10, 10)),
      AppImage.source,
    );
    final BitmapDescriptor driverIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(10, 10)),
      AppImage.carMap,
    );
    markers.add(
      Marker(
        markerId: MarkerId("pickup"),
        position:
            LatLng(pickupLat ?? 0.0, pickupLong ?? 0.0), // Pickup Location
        icon: driverIcon,
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId("Driver"),
        position: LatLng(destLat ?? 0.0, destLng ?? 0.0), // Drop Location
        icon: pickupIcon,
      ),
    );
    notifyListeners();
  }
}
