class DriverDetails {
  final String sendRequestId;
  final String pickupAddress;
  final double pickupLat;
  final double pickupLong;
  final String dropAddress;
  final double dropLat;
  final double dropLong;
  final String driverName;
  final int driverId;
  final String mobileNo;
  final String driverProfilePic;
  final String email;
  final int driverAway;
  final int userJourneyDistance;
  final int totalFare;
  final String vehicleName;
  final String vehicleImage;
  final String status;
  final String message;
  final int statusCode;

  DriverDetails({
    required this.sendRequestId,
    required this.pickupAddress,
    required this.pickupLat,
    required this.pickupLong,
    required this.dropAddress,
    required this.dropLat,
    required this.dropLong,
    required this.driverName,
    required this.driverId,
    required this.mobileNo,
    required this.driverProfilePic,
    required this.email,
    required this.driverAway,
    required this.userJourneyDistance,
    required this.totalFare,
    required this.vehicleName,
    required this.vehicleImage,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  // Factory constructor to create an instance from JSON
  factory DriverDetails.fromJson(Map<String, dynamic> json) {
    return DriverDetails(
      sendRequestId: json['send_request_id'] as String,
      pickupAddress: json['pickup_address'] as String,
      pickupLat: (json['pickup_lat'] as num).toDouble(),
      pickupLong: (json['pickup_long'] as num).toDouble(),
      dropAddress: json['drop_address'] as String,
      dropLat: (json['drop_lat'] as num).toDouble(),
      dropLong: (json['drop_long'] as num).toDouble(),
      driverName: json['driver_name'] as String,
      driverId: json['driver_id'] as int,
      mobileNo: json['mobile_no'].toString(), // Converting to String if required
      driverProfilePic: json['driver_profile_pic'] as String,
      email: json['email'] as String,
      driverAway: json['driver_away'] as int,
      userJourneyDistance: json['user_journey_distance'] as int,
      totalFare: json['total_fare'] as int,
      vehicleName: json['vehicle_name'] as String,
      vehicleImage: json['vehicle_image'] as String,
      status: json['status'] as String,
      message: json['message'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'send_request_id': sendRequestId,
      'pickup_address': pickupAddress,
      'pickup_lat': pickupLat,
      'pickup_long': pickupLong,
      'drop_address': dropAddress,
      'drop_lat': dropLat,
      'drop_long': dropLong,
      'driver_name': driverName,
      'driver_id': driverId,
      'mobile_no': mobileNo,
      'driver_profile_pic': driverProfilePic,
      'email': email,
      'driver_away': driverAway,
      'user_journey_distance': userJourneyDistance,
      'total_fare': totalFare,
      'vehicle_name': vehicleName,
      'vehicle_image': vehicleImage,
      'status': status,
      'message': message,
      'statusCode': statusCode,
    };
  }
}
