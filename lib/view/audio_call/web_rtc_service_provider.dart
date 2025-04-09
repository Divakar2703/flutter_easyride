import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/main.dart';
import 'package:flutter_easy_ride/utils/toast.dart';
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
  bool isRideStarted = false;
  Logger logger = Logger();
  double? driverLat;
  double? driverLong;
  GoogleMapController? mapController;
  DriverDetailsModel? driverDetailsModel;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  LatLng? currentLocation;
  List<LatLng> polylineCoordinates = [];
  String? otp;

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
    notifyListeners();
  }

  Future<void> initSocket(String id) async {
    socket = IO.io(
      'https://cabsocket.asatvindia.in:5005',
      IO.OptionBuilder().setTransports(['websocket']).setReconnectionAttempts(5).build(),
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
      currentLocation =
          LatLng(driverDetailsModel?.waypoints?.first.lat ?? 0.0, driverDetailsModel?.waypoints?.first.long ?? 0.0);
      notifyListeners();
      driverDetailsModel = DriverDetailsModel.fromJson(data);

      markers.add(
        Marker(
          markerId: MarkerId("source"),
          position:
              LatLng(driverDetailsModel?.waypoints?.first.lat ?? 0.0, driverDetailsModel?.waypoints?.first.long ?? 0.0),
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

    socket.on('pickup_location_reached', (data) => _pickupLocationReached(data));

    socket.on('ride_cancelled', (data) => _rideCancelListen(data));

    socket.on('ride_started', (data) => _rideStarted(data));

    socket.on('ride_finished', (data) => _finishRideListen(data));

    _initializePeerConnection();
  }

  _pickupLocationReached(data) {
    otp = data["otp"].toString();
    AppUtils.show("Driver arrived.");
    notifyListeners();
  }

  _rideStarted(data) {
    isRideStarted = true;
    polylineCoordinates.clear();
    markers.clear();
    notifyListeners();
  }

  Future<void> _finishRideListen(data) async {
    AppUtils.show("Ride Finished");
    clearAllData();
  }

  clearAllData() {
    markers.clear();
    driverLat = null;
    driverLong = null;
    currentLocation = null;
    driverDetailsModel = null;
    polylineCoordinates.clear();
    polylinePoints = PolylinePoints();
    notifyListeners();
    getX.Get.offAll(() => BottomBarScreen());
  }

  _rideCancelListen(data) {
    AppUtils.show(data["reason"].toString());
    clearAllData();
  }

  _updateDriverLocation(data) async {
    driverLat = data["latitude"];
    driverLong = data["longitude"];

    if (isRideStarted) {
      drawCompletePolyLine(LatLng(driverLat ?? 0.0, driverLong ?? 0.0), driverDetailsModel);
    } else {
      await addPolyLine(driverLat: driverLat, driverLong: driverLong, isPickup: true);
      addMarkers(
          driverLat: driverLat, driverLong: driverLong, waypoints: driverDetailsModel?.waypoints, isPickup: true);
    }
    notifyListeners();
  }

  drawCompletePolyLine(LatLng? currentLocation, DriverDetailsModel? driverDetailsModel) async {
    if (currentLocation == null ||
        driverDetailsModel?.waypoints == null ||
        (driverDetailsModel?.waypoints?.isEmpty ?? true)) return;

    final origin = PointLatLng(currentLocation.latitude, currentLocation.longitude);

    // Convert waypoints to lat/lng points
    List<PointLatLng> allPoints =
        driverDetailsModel?.waypoints!.map((e) => PointLatLng(e.lat ?? 0.0, e.long ?? 0.0)).toList() ?? [];

    /// ✅ Remove waypoints before currentLocation (by finding the closest one and trimming before it)
    int closestIndex = 0;
    double minDistance = double.infinity;

    for (int i = 0; i < allPoints.length; i++) {
      final distance = _calculateDistance(
        currentLocation.latitude,
        currentLocation.longitude,
        allPoints[i].latitude,
        allPoints[i].longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }

    // Trim waypoints to only forward path
    final forwardWaypoints = allPoints.sublist(closestIndex);

    final destination = forwardWaypoints.last;

    List<PolylineWayPoint> wayPoints = forwardWaypoints.length > 1
        ? forwardWaypoints.sublist(0, forwardWaypoints.length - 1).map((e) {
            return PolylineWayPoint(location: "${e.latitude},${e.longitude}");
          }).toList()
        : [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: Endpoints.googleApiKey,
      request: PolylineRequest(
        origin: origin,
        destination: destination,
        wayPoints: wayPoints,
        mode: TravelMode.driving,
      ),
    );

    polylineCoordinates.clear();
    markers.clear();

    if (result.points.isNotEmpty) {
      polylineCoordinates = result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();

      // Add driver marker
      markers.add(
        Marker(
          markerId: MarkerId("Driver"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          icon: await BitmapDescriptor.asset(
            ImageConfiguration(size: Size(45, 45)),
            driverDetailsModel?.type?.toLowerCase() == "car"
                ? AppImage.carMap
                : driverDetailsModel?.type?.toLowerCase() == "auto"
                    ? AppImage.autoMap
                    : driverDetailsModel?.type?.toLowerCase() == "bike"
                        ? AppImage.bikeMap
                        : "",
          ),
        ),
      );

      // Add waypoint & destination markers
      for (int i = 0; i < forwardWaypoints.length; i++) {
        final point = forwardWaypoints[i];
        final isDestination = i == forwardWaypoints.length - 1;

        markers.add(
          Marker(
            markerId: MarkerId(isDestination ? 'destination' : 'waypoint_$i'),
            position: LatLng(point.latitude, point.longitude),
            infoWindow: InfoWindow(title: isDestination ? 'Destination' : 'Stop ${i + 1}'),
            icon: await BitmapDescriptor.asset(
              ImageConfiguration(size: Size(10, 10)),
              isDestination ? AppImage.destination : AppImage.source,
            ),
          ),
        );
      }

      // Animate camera to route bounds
      final bounds = _createLatLngBounds(polylineCoordinates);
      await mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));

      notifyListeners();
    } else {
      print("Polyline error: ${result.errorMessage}");
    }
  }

  addPolyLine({double? driverLat, double? driverLong, bool? isPickup}) async {
    if (isPickup ?? false) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: Endpoints.googleApiKey,
          request: PolylineRequest(
              origin: PointLatLng(driverLat ?? 0.0, driverLong ?? 0.0),
              destination: PointLatLng(
                  driverDetailsModel?.waypoints?.first.lat ?? 0.0, driverDetailsModel?.waypoints?.first.long ?? 0.0),
              mode: TravelMode.driving));

      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();
        notifyListeners();
      }
    }
  }

  addMarkers({double? driverLat, double? driverLong, List<Waypoints>? waypoints, bool? isPickup}) async {
    if (isPickup ?? false) {
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
        ),
      );
      await Future.delayed(Duration(seconds: 1));
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
    _localStream = await navigator.mediaDevices.getUserMedia({'audio': true, 'video': false});
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
    socket.emit('answer_call', {'toUserId': incomingCallerId, 'answer': answer.toMap()});
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

  Future<void> getPolyPoints({double? pickupLat, double? pickupLong, double? destLat, double? destLng}) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: Endpoints.googleApiKey,
          request: PolylineRequest(
              origin: PointLatLng(pickupLat ?? 0.0, pickupLong ?? 0.0),
              destination: PointLatLng(destLat ?? 0.0, destLng ?? 0.0),
              mode: TravelMode.driving));

      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();
        notifyListeners();
      }
    } catch (error) {
      print("Error getting route: $error");
    }
  }

  void cancelRideFromUser(String reason) {
    socket.emit('cancel_ride', {"booking_id": driverDetailsModel?.bookingId, "reason": reason});
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371; // in km
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) + cos(_degToRad(lat1)) * cos(_degToRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degToRad(double deg) => deg * (pi / 180);

  LatLngBounds _createLatLngBounds(List<LatLng> points) {
    double x0 = points.first.latitude;
    double x1 = points.first.latitude;
    double y0 = points.first.longitude;
    double y1 = points.first.longitude;

    for (LatLng point in points) {
      if (point.latitude > x1) x1 = point.latitude;
      if (point.latitude < x0) x0 = point.latitude;
      if (point.longitude > y1) y1 = point.longitude;
      if (point.longitude < y0) y0 = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(x0, y0),
      northeast: LatLng(x1, y1),
    );
  }
}
