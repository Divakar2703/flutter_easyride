import 'dart:convert';

class HistoryResponse {
  final List<DropLocation> list;
  final String status;
  final int statusCode;
  final String message;

  HistoryResponse({
    required this.list,
    required this.status,
    required this.statusCode,
    required this.message,
  });

  // Factory constructor to create an instance of BookingResponse from JSON
  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      list: List<DropLocation>.from(json['list'].map((x) => DropLocation.fromJson(x))),
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  // Method to convert an instance of BookingResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'list': list.map((x) => x.toJson()).toList(),
      'status': status,
      'statusCode': statusCode,
      'message': message,
    };
  }
}

class DropLocation {
  final String id;
  final String dropLat;
  final String dropLong;
  final String dropAddress;
  final String bookingType;

  DropLocation({
    required this.id,
    required this.dropLat,
    required this.dropLong,
    required this.dropAddress,
    required this.bookingType,
  });

  // Factory constructor to create an instance of Booking from JSON
  factory DropLocation.fromJson(Map<String, dynamic> json) {
    return DropLocation(
      id: json['id'] ?? '',
      dropLat: json['drop_lat'] ?? '',
      dropLong: json['drop_long'] ?? '',
      dropAddress: json['drop_address'] ?? '',
      bookingType: json['booking_type'] ?? '',
    );
  }

  // Method to convert an instance of Booking to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'drop_lat': dropLat,
      'drop_long': dropLong,
      'drop_address': dropAddress,
      'booking_type': bookingType,
    };
  }
}
