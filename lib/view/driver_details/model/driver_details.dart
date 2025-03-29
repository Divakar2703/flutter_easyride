import 'dart:convert';

class DriverDetailsModel {
  final String? driverId;
  final String? arrivingTime;
  final String? rating;
  final String? driverName;
  final String? driverMobile;
  final String? driverProfile;
  final String? vehicleImage;
  final String? vehicleMake;
  final String? vehicleModel;
  final String? vehicleNo;
  final String? vehicleColour;
  final String? vehicleRegYear;
  final List<WayPointModel>? waypoints;
  final String? userJourneyDistance;
  final String? totalFare;
  final String? convCharge;
  final String? grandTotal;
  final String? userId;
  final String? walletAmount;
  final String? bookingId;

  DriverDetailsModel({
    this.driverId,
    this.arrivingTime,
    this.rating,
    this.driverName,
    this.driverMobile,
    this.driverProfile,
    this.vehicleImage,
    this.vehicleMake,
    this.vehicleModel,
    this.vehicleNo,
    this.vehicleColour,
    this.vehicleRegYear,
    this.waypoints,
    this.userJourneyDistance,
    this.totalFare,
    this.convCharge,
    this.grandTotal,
    this.userId,
    this.walletAmount,
    this.bookingId,
  });

  factory DriverDetailsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonData = jsonDecode(json["waypoints"]);
    return DriverDetailsModel(
      driverId: json['driver_id'],
      arrivingTime: json['arriving_time'],
      rating: json['rating'],
      driverName: json['driver_name'],
      driverMobile: json['driver_mobile'],
      driverProfile: json['driver_profile'],
      vehicleImage: json['vehicle_image'],
      vehicleMake: json['vehicle_make'],
      vehicleModel: json['vehicle_model'],
      vehicleNo: json['vehicle_no'],
      vehicleColour: json['vehicle_colour'],
      vehicleRegYear: json['vehicle_reg_year'],
      waypoints: (json['waypoints'] != null)
          ? jsonData.map((e) => WayPointModel.fromJson(e)).toList()
          : null,
      userJourneyDistance: json['user_journey_distance'],
      totalFare: json['total_fare'],
      convCharge: json['conv_charge'],
      grandTotal: json['grand_total'],
      userId: json['user_id'],
      walletAmount: json['wallet_amount'],
      bookingId: json['booking_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driver_id': driverId,
      'arriving_time': arrivingTime,
      'rating': rating,
      'driver_name': driverName,
      'driver_mobile': driverMobile,
      'driver_profile': driverProfile,
      'vehicle_image': vehicleImage,
      'vehicle_make': vehicleMake,
      'vehicle_model': vehicleModel,
      'vehicle_no': vehicleNo,
      'vehicle_colour': vehicleColour,
      'vehicle_reg_year': vehicleRegYear,
      'waypoints': waypoints != null ? jsonEncode(waypoints) : null,
      'user_journey_distance': userJourneyDistance,
      'total_fare': totalFare,
      'conv_charge': convCharge,
      'grand_total': grandTotal,
      'user_id': userId,
      'wallet_amount': walletAmount,
      'booking_id': bookingId,
    };
  }
}

class WayPointModel {
  final double? latitude;
  final double? longitude;
  final String? address;
  WayPointModel({this.latitude, this.longitude, this.address});

  factory WayPointModel.fromJson(Map<String, dynamic> json) {
    return WayPointModel(
        latitude: json["lat"],
        longitude: json["long"],
        address: json["address"]);
  }

  Map<String, dynamic> toJson() {
    return {"latitude": latitude, "longitude": longitude, "address": address};
  }
}
