class DriverDetails {
  final String status;
  final String sendRequestId;
  final String pickupAddress;
  final double pickupLat;
  final double pickupLong;
  final String dropAddress;
  final double dropLat;
  final double dropLong;
  final String driverName;
  final String driverId;
  final String mobileNo;
  final String driverProfilePic;
  final String email;
  final int driverAway;
  final double userJourneyDistance;
  final double totalFare;
  final String vehicleName;
  final String vehicleImage;

  DriverDetails({
    required this.status,
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
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) {
    double _parseDouble(dynamic value) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return DriverDetails(
      status: json['status'] ?? '',
      sendRequestId: json['send_request_id'].toString(),
      pickupAddress: json['pickup_address'] ?? '',
      pickupLat: _parseDouble(json['pickup_lat']),
      pickupLong: _parseDouble(json['pickup_long']),
      dropAddress: json['drop_address'] ?? '',
      dropLat: _parseDouble(json['drop_lat']),
      dropLong: _parseDouble(json['drop_long']),
      driverName: json['driver_name'] ?? '',
      driverId: json['driver_id'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      driverProfilePic: json['driver_profile_pic'] ?? '',
      email: json['email'] ?? '',
      driverAway: json['driver_away'] ?? 0,
      userJourneyDistance: _parseDouble(json['user_journey_distance']),
      totalFare: _parseDouble(json['total_fare']),
      vehicleName: json['vehicle_name'] ?? '',
      vehicleImage: json['vehicle_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
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
    };
  }
}
