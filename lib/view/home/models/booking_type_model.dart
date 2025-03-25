class BookingTypeModel {
  String? status;
  int? statusCode;
  String? message;
  List<BookingTypeDataModel>? data;

  BookingTypeModel({this.status, this.statusCode, this.message, this.data});

  BookingTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookingTypeDataModel>[];
      json['data'].forEach((v) {
        data!.add(new BookingTypeDataModel.fromJson(v));
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

class BookingTypeDataModel {
  String? id;
  String? name;
  String? image;
  String? icon;
  String? bookingType;

  BookingTypeDataModel({this.id, this.name, this.image, this.icon, this.bookingType});

  BookingTypeDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    icon = json['icon'];
    bookingType = json['booking_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['icon'] = this.icon;
    data['booking_type'] = this.bookingType;
    return data;
  }
}
