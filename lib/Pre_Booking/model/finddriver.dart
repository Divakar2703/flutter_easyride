import 'dart:convert';

FindDriver findDriverFromJson(String str) => FindDriver.fromJson(json.decode(str));

String findDriverToJson(FindDriver data) => json.encode(data.toJson());

class FindDriver {
    String sendRequestId;
    String pickupAddress;
    double pickupLat;
    double pickupLong;
    String dropAddress;
    double dropLat;
    double dropLong;
    String driverName;
    int driverId;
    int mobileNo;
    String driverProfilePic;
    String email;
    int driverAway;
    int userJourneyDistance;
    int totalFare;
    String vehicleName;
    String vehicleImage;
    String rating;
    String feedback;
    String status;
    String message;
    int statusCode;

    FindDriver({
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
        required this.rating,
        required this.feedback,
        required this.status,
        required this.message,
        required this.statusCode,
    });

    factory FindDriver.fromJson(Map<String, dynamic> json) => FindDriver(
        sendRequestId: json["send_request_id"],
        pickupAddress: json["pickup_address"],
        pickupLat: json["pickup_lat"]?.toDouble(),
        pickupLong: json["pickup_long"]?.toDouble(),
        dropAddress: json["drop_address"],
        dropLat: json["drop_lat"]?.toDouble(),
        dropLong: json["drop_long"]?.toDouble(),
        driverName: json["driver_name"],
        driverId: json["driver_id"],
        mobileNo: json["mobile_no"],
        driverProfilePic: json["driver_profile_pic"],
        email: json["email"],
        driverAway: json["driver_away"],
        userJourneyDistance: json["user_journey_distance"],
        totalFare: json["total_fare"],
        vehicleName: json["vehicle_name"],
        vehicleImage: json["vehicle_image"],
        rating: json["rating"],
        feedback: json["feedback"],
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "send_request_id": sendRequestId,
        "pickup_address": pickupAddress,
        "pickup_lat": pickupLat,
        "pickup_long": pickupLong,
        "drop_address": dropAddress,
        "drop_lat": dropLat,
        "drop_long": dropLong,
        "driver_name": driverName,
        "driver_id": driverId,
        "mobile_no": mobileNo,
        "driver_profile_pic": driverProfilePic,
        "email": email,
        "driver_away": driverAway,
        "user_journey_distance": userJourneyDistance,
        "total_fare": totalFare,
        "vehicle_name": vehicleName,
        "vehicle_image": vehicleImage,
        "rating": rating,
        "feedback": feedback,
        "status": status,
        "message": message,
        "statusCode": statusCode,
    };
}
