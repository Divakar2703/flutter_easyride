import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/main.dart';
import 'package:flutter_easy_ride/view/audio_call/incommin_call_screen.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebRTCProvider with ChangeNotifier {
  late IO.Socket socket;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  String? incomingCallerId;
  bool isCallActive = false;

  final String userId;

  WebRTCProvider(this.userId) {
    _localRenderer.initialize();
    _initSocket();
    _initializePeerConnection();
  }

  RTCVideoRenderer get localRenderer => _localRenderer;

  void _initSocket() {
    socket = IO.io('https://asatvindia.in:5001', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected to signaling server');
      socket.emit('registerUser', userId);
    });

    socket.on('incoming_call', (data) async {
      print("Incoming call from: ${data['fromUserId']}");
      incomingCallerId = data['fromUserId'];
      notifyListeners();

      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(data['offer']['sdp'], data['offer']['type']),
      );
      showDialog(
        context: navigatorKey.currentState!.context,
        barrierDismissible: false,
        builder: (BuildContext context) => IncomingCallDialog(fromUserId: incomingCallerId!),
      );
    });

    socket.on('call_answered', (data) async {
      print("Call answered");
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(data['answer']['sdp'], data['answer']['type']),
      );
      isCallActive = true;
      notifyListeners();
    });

    socket.on('ice_candidate', (data) async {
      print("Received ICE candidate");
      await _peerConnection!.addCandidate(RTCIceCandidate(
        data['candidate']['candidate'],
        data['candidate']['sdpMid'],
        data['candidate']['sdpMLineIndex'],
      ));
    });
  }

  Future<void> _initializePeerConnection() async {
    _localStream = await navigator.mediaDevices.getUserMedia({'audio': true});
    _localRenderer.srcObject = _localStream;

    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ],
    });

    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      print("Sending ICE candidate");
      socket.emit('ice_candidate', {
        'toUserId': userId,
        'candidate': candidate.toMap(),
      });
    };
  }

  Future<void> callUser(String toUserId) async {
    RTCSessionDescription offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    socket.emit('call_user', {
      'fromUserId': userId,
      'toUserId': toUserId,
      'offer': offer.toMap(),
    });
  }

  Future<void> acceptCall() async {
    if (incomingCallerId == null) return;

    RTCSessionDescription answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);
    socket.emit('answer_call', {
      'toUserId': incomingCallerId,
      'answer': answer.toMap(),
    });

    isCallActive = true;
    incomingCallerId = null;
    notifyListeners();
  }

  void rejectCall() {
    incomingCallerId = null;
    notifyListeners();
  }

  void disposeService() {
    _localRenderer.dispose();
    socket.dispose();
    _peerConnection?.close();
    super.dispose();
  }
}
