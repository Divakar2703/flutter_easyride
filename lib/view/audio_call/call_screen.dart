import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/view/audio_call/web_rtc_service_provider.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatelessWidget {
  final String? userId;
  final String? peerId;
  final bool? isReceiver;
  CallScreen({this.userId, this.peerId, this.isReceiver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Call ${peerId}")),
      body: isReceiver ?? false
          ? SizedBox()
          : Center(
              child: ElevatedButton(
                onPressed: () => context.read<WebRTCProvider>().callUser(peerId!),
                child: Text("Start Call"),
              ),
            ),
    );
  }
}
