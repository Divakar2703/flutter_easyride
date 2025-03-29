class BookingModel {
  String? status;
  int? statusCode;
  String? message;
  BookingDataModel? data;

  BookingModel({this.status, this.statusCode, this.message, this.data});

  BookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new BookingDataModel.fromJson(json['data']) : null;
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

class BookingDataModel {
  String? bookingId;

  BookingDataModel({this.bookingId});

  BookingDataModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    return data;
  }
}
