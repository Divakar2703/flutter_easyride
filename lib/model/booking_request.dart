class BookingRequest {
  final String vehicleTypeId;
  final int reqId;
  final String status;
  final String message;
  final int statusCode;

  BookingRequest({
    required this.vehicleTypeId,
    required this.reqId,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  // Factory constructor to create an instance from JSON
  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      vehicleTypeId: json['vehicle_type_id'],
      reqId: json['req_id'],
      status: json['status'],
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'vehicle_type_id': vehicleTypeId,
      'req_id': reqId,
      'status': status,
      'message': message,
      'statusCode': statusCode,
    };
  }
}
