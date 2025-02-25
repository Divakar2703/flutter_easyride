class NearByVehicle {
  List<NearbyCab>? vehicle;
  String? status;
  String? message;
  int? statusCode;

  NearByVehicle({this.vehicle, this.status, this.message, this.statusCode});

  NearByVehicle.fromJson(Map<String, dynamic> json) {
    if (json['vehicle'] != null) {
      vehicle = <NearbyCab>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(new NearbyCab.fromJson(v));
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

class NearbyCab {
  String? id;
  String? name;
  String? image;
  String? description;
  String? type;
  String? currLat;
  String? currLong;

  NearbyCab({this.id, this.name, this.image, this.description, this.type, this.currLat, this.currLong});

  NearbyCab.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    type = json['type'];
    currLat = json['curr_lat'];
    currLong = json['curr_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['type'] = this.type;
    data['curr_lat'] = this.currLat;
    data['curr_long'] = this.currLong;
    return data;
  }
}
