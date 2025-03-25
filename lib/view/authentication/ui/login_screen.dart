import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/toast.dart';
import 'package:flutter_easy_ride/view/authentication/provider/auth_provider.dart';
import 'package:flutter_easy_ride/view/authentication/ui/verify_otp_screen.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                child: Center(child: Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Login with your mobile number to continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 40),
                        CommonTextField(
                          con: _mobileController,
                          fillColor: AppColors.white,
                          keyBoardType: TextInputType.phone,
                          hintText: "Enter your phone number",
                          prefixIcon: Icon(Icons.phone),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 10) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CommonButton(
                          label: "Send OTP",
                          load: authProvider.loadOtp,
                          width: MediaQuery.of(context).size.width / 2,
                          onPressed: () async {
                            final mobileNumber = _mobileController.text;
                            if (mobileNumber.length == 10) {
                              bool success = await authProvider.sendOtp(mobileNumber);
                              if (success) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => VerifyScreen()),
                                );
                              } else {
                                AppUtils.show("Failed to send OTP");
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Enter a valid mobile number')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
