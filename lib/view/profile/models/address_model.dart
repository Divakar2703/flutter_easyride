class AddressModel {
  String? status;
  int? statusCode;
  String? message;
  List<AddressDataModel>? data;

  AddressModel({this.status, this.statusCode, this.message, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressDataModel>[];
      json['data'].forEach((v) {
        data!.add(new AddressDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressDataModel {
  String? id;
  String? userId;
  String? type;
  String? address;
  String? latitude;
  String? longitude;

  AddressDataModel({this.id, this.userId, this.type, this.address, this.latitude, this.longitude});

  AddressDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
