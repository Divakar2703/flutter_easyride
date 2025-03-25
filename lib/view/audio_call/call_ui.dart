import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/view/audio_call/web_rtc_service_provider.dart';
import 'package:provider/provider.dart';

class CallUi extends StatelessWidget {
  const CallUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Consumer<WebRTCProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 120,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  "In Call...",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: provider.toggleMic,
                      icon: Icon(
                        provider.isMicMuted ? Icons.mic_off : Icons.mic,
                        color: provider.isMicMuted ? Colors.red : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: provider.toggleSpeaker,
                      icon: Icon(
                        provider.isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                        color: provider.isSpeakerOn ? Colors.green : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        provider.rejectCall();
                        provider.disposeService();
                      },
                      icon: Icon(Icons.call_end, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
