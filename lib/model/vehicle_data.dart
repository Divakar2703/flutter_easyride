class VehicleResponse {
  String? status;
  int? statusCode;
  String? message;
  VehicleDataModel? data;

  VehicleResponse({this.status, this.statusCode, this.message, this.data});

  VehicleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new VehicleDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class VehicleDataModel {
  String? walletAmount;
  List<VehicleList>? vehicleList;

  VehicleDataModel({this.walletAmount, this.vehicleList});

  VehicleDataModel.fromJson(Map<String, dynamic> json) {
    walletAmount = json['wallet_amount'];
    if (json['vehicle_list'] != null) {
      vehicleList = <VehicleList>[];
      json['vehicle_list'].forEach((v) {
        vehicleList!.add(new VehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_amount'] = this.walletAmount;
    if (this.vehicleList != null) {
      data['vehicle_list'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleList {
  String? id;
  String? name;
  String? image;
  String? description;
  String? type;
  String? seat;
  String? promocodeStatus;
  String? distance;
  String? travelTime;
  String? fare;
  String? discount;
  String? netFare;
  String? grandTotal;
  bool isSelected = false;

  VehicleList({
    this.id,
    this.name,
    this.image,
    this.description,
    this.type,
    this.seat,
    this.promocodeStatus,
    this.distance,
    this.travelTime,
    this.fare,
    this.discount,
    this.netFare,
    this.grandTotal,
  });

  VehicleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    type = json['type'];
    seat = json['seat'];
    promocodeStatus = json['promocode_status'];
    distance = json['distance'];
    travelTime = json['travel_time'];
    fare = json['fare'];
    discount = json['discount'];
    netFare = json['net_fare'];
    grandTotal = json['grand_total'];
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
    data['distance'] = this.distance;
    data['travel_time'] = this.travelTime;
    data['fare'] = this.fare;
    data['discount'] = this.discount;
    data['net_fare'] = this.netFare;
    data['grand_total'] = this.grandTotal;
    return data;
  }
}
