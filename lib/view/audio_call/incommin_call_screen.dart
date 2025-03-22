import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/view/audio_call/call_screen.dart';
import 'package:flutter_easy_ride/view/audio_call/web_rtc_service_provider.dart';
import 'package:provider/provider.dart';

class IncomingCallDialog extends StatelessWidget {
  final String fromUserId;

  IncomingCallDialog({required this.fromUserId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Incoming Call"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.call, size: 50, color: Colors.green),
          SizedBox(height: 10),
          Text("Call from: $fromUserId"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<WebRTCProvider>().rejectCall();
            Navigator.pop(context); // Close dialog
          },
          child: Text("Reject", style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () async {
            await context.read<WebRTCProvider>().acceptCall();
            Navigator.pop(context);

            // Navigate to Call Screen
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    userId: "10",
                  ),
                ));
          },
          child: Text("Accept"),
        ),
      ],
    );
  }
}
