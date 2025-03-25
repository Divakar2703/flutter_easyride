import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/view/authentication/provider/auth_provider.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatelessWidget {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  color: AppColors.black.withOpacity(0.1),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: SafeArea(
              child: Center(child: Text("Verify OTP", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Verify OTP',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter the OTP sent to \n${authProvider.mobileNumber}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 30),
                    Card(
                      elevation: 8,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              'Enter OTP',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            PinCodeTextField(
                              appContext: context,
                              length: 6,
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(8),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                selectedColor: AppColors.yellowDark,
                                inactiveColor: Colors.grey,
                              ),
                              animationDuration: Duration(milliseconds: 300),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CommonButton(
                      label: "Verify OTP",
                      load: authProvider.loadVerifyOtp,
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () async {
                        final otp = _otpController.text;
                        if (otp.length == 6) {
                          await authProvider.verifyOtp(otp);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Enter a valid OTP')),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // Resend OTP logic
                      },
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(fontSize: 14, color: AppColors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
