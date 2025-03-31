class DriverDetailsModel {
  String? driverId;
  String? arrivingTime;
  String? rating;
  String? driverName;
  String? driverMobile;
  String? driverProfile;
  String? vehicleImage;
  String? vehicleMake;
  String? vehicleModel;
  String? vehicleNo;
  String? vehicleColour;
  String? vehicleRegYear;
  List<Waypoints>? waypoints;
  String? userJourneyDistance;
  String? totalFare;
  String? convCharge;
  String? grandTotal;
  String? userId;
  String? walletAmount;
  String? bookingId;

  DriverDetailsModel(
      {this.driverId,
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
      this.bookingId});

  DriverDetailsModel.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    arrivingTime = json['arriving_time'];
    rating = json['rating'];
    driverName = json['driver_name'];
    driverMobile = json['driver_mobile'];
    driverProfile = json['driver_profile'];
    vehicleImage = json['vehicle_image'];
    vehicleMake = json['vehicle_make'];
    vehicleModel = json['vehicle_model'];
    vehicleNo = json['vehicle_no'];
    vehicleColour = json['vehicle_colour'];
    vehicleRegYear = json['vehicle_reg_year'];
    if (json['waypoints'] != null) {
      waypoints = <Waypoints>[];
      json['waypoints'].forEach((v) {
        waypoints!.add(new Waypoints.fromJson(v));
      });
    }
    userJourneyDistance = json['user_journey_distance'];
    totalFare = json['total_fare'];
    convCharge = json['conv_charge'];
    grandTotal = json['grand_total'];
    userId = json['user_id'];
    walletAmount = json['wallet_amount'];
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.driverId;
    data['arriving_time'] = this.arrivingTime;
    data['rating'] = this.rating;
    data['driver_name'] = this.driverName;
    data['driver_mobile'] = this.driverMobile;
    data['driver_profile'] = this.driverProfile;
    data['vehicle_image'] = this.vehicleImage;
    data['vehicle_make'] = this.vehicleMake;
    data['vehicle_model'] = this.vehicleModel;
    data['vehicle_no'] = this.vehicleNo;
    data['vehicle_colour'] = this.vehicleColour;
    data['vehicle_reg_year'] = this.vehicleRegYear;
    if (this.waypoints != null) {
      data['waypoints'] = this.waypoints!.map((v) => v.toJson()).toList();
    }
    data['user_journey_distance'] = this.userJourneyDistance;
    data['total_fare'] = this.totalFare;
    data['conv_charge'] = this.convCharge;
    data['grand_total'] = this.grandTotal;
    data['user_id'] = this.userId;
    data['wallet_amount'] = this.walletAmount;
    data['booking_id'] = this.bookingId;
    return data;
  }
}

class Waypoints {
  double? lat;
  double? long;
  String? address;

  Waypoints({this.lat, this.long, this.address});

  Waypoints.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['address'] = this.address;
    return data;
  }
}
