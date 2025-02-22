import 'dart:convert';

class LoginResponse {
  final String loginUserName;
  final String loginUserEmail;
  final String loginUserId;
  final int userExist;
  final String status;
  final String message;
  final int statusCode;

  LoginResponse({
    required this.loginUserName,
    required this.loginUserEmail,
    required this.loginUserId,
    required this.userExist,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  // Factory constructor to create an instance from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      loginUserName: json['loginUser_name'] as String,
      loginUserEmail: json['loginUser_email'] as String,
      loginUserId: json['loginUser_id'].toString(),
      userExist: json['user_exist'] as int,
      status: json['status'] as String,
      message: json['message'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'loginUser_name': loginUserName,
      'loginUser_email': loginUserEmail,
      'loginUser_id': loginUserId,
      'user_exist': userExist,
      'status': status,
      'message': message,
      'statusCode': statusCode,
    };
  }
}
