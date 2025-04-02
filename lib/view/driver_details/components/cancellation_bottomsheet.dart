import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:provider/provider.dart';
import '../../audio_call/web_rtc_service_provider.dart';

class CancellationReasonBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WebRTCProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Why do you want to cancel?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Please provide the reason for cancellation",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.reasons.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            provider.reasons[index],
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Radio<String>(
                            value: provider.reasons[index],
                            groupValue: provider.selectedReason,
                            activeColor: AppColors.yellowDark,
                            onChanged: (value) {
                              provider.selectReason(value!);
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Divider(
                          height: 0,
                          color: AppColors.black
                              .withOpacity(0.2), // Low-opacity divider
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              CommonButton(
                label: "Continue",
                onPressed: provider.selectedReason != null
                    ? () {
                        provider
                            .cancelRideFromUser(provider.selectedReason ?? "");
                        print("Selected Reason: ${provider.selectedReason}");
                        Navigator.pop(context);
                      }
                    : null,
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
