class VehicleResponse {
  List<Vehicle>? vehicle;
  String? status;
  String? message;
  int? statusCode;

  VehicleResponse({this.vehicle, this.status, this.message, this.statusCode});

  VehicleResponse.fromJson(Map<String, dynamic> json) {
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(new Vehicle.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Vehicle {
  String? id;
  String? name;
  String? image;
  String? description;
  String? type;
  String? seat;
  String? promocodeStatus;
  double? fare;
  String? discount;
  double? netFare;
  bool isSelected = false;

  Vehicle(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.type,
      this.seat,
      this.promocodeStatus,
      this.fare,
      this.discount,
      this.netFare});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    type = json['type'];
    seat = json['seat'];
    promocodeStatus = json['promocode_status'];
    fare = json['fare'];
    discount = json['discount'];
    netFare = json['net_fare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['type'] = this.type;
    data['seat'] = this.seat;
    data['promocode_status'] = this.promocodeStatus;
    data['fare'] = this.fare;
    data['discount'] = this.discount;
    data['net_fare'] = this.netFare;
    return data;
  }
}
