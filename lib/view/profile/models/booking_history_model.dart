class BookingHistoryModel {
  String? status;
  int? statusCode;
  String? message;
  BookingHistoryDataModel? data;

  BookingHistoryModel({this.status, this.statusCode, this.message, this.data});

  BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new BookingHistoryDataModel.fromJson(json['data']) : null;
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

class BookingHistoryDataModel {
  int? currentPage;
  int? totalPages;
  int? totalRecords;
  int? recordsPerPage;
  List<BookingHistoryList>? data;

  BookingHistoryDataModel({this.currentPage, this.totalPages, this.totalRecords, this.recordsPerPage, this.data});

  BookingHistoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    totalRecords = json['total_records'];
    recordsPerPage = json['records_per_page'];
    if (json['data'] != null) {
      data = <BookingHistoryList>[];
      json['data'].forEach((v) {
        data!.add(new BookingHistoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    data['total_records'] = this.totalRecords;
    data['records_per_page'] = this.recordsPerPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingHistoryList {
  String? bookingId;
  String? bookingType;
  String? driverName;
  String? driverProfile;
  String? makeName;
  String? modelName;
  String? userJourneyDistance;
  String? travelTime;
  String? grandTotal;
  String? paymentType;
  String? bookingDate;
  List<Waypoints>? waypoints;

  BookingHistoryList(
      {this.bookingId,
      this.bookingType,
      this.driverName,
      this.driverProfile,
      this.makeName,
      this.modelName,
      this.userJourneyDistance,
      this.travelTime,
      this.grandTotal,
      this.paymentType,
      this.bookingDate,
      this.waypoints});

  BookingHistoryList.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingType = json['booking_type'];
    driverName = json['driver_name'];
    driverProfile = json['driver_profile'];
    makeName = json['make_name'];
    modelName = json['model_name'];
    userJourneyDistance = json['user_journey_distance'];
    travelTime = json['travel_time'];
    grandTotal = json['grand_total'];
    paymentType = json['payment_type'];
    bookingDate = json['booking_date'];
    if (json['waypoints'] != null) {
      waypoints = <Waypoints>[];
      json['waypoints'].forEach((v) {
        waypoints!.add(new Waypoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_type'] = this.bookingType;
    data['driver_name'] = this.driverName;
    data['driver_profile'] = this.driverProfile;
    data['make_name'] = this.makeName;
    data['model_name'] = this.modelName;
    data['user_journey_distance'] = this.userJourneyDistance;
    data['travel_time'] = this.travelTime;
    data['grand_total'] = this.grandTotal;
    data['payment_type'] = this.paymentType;
    data['booking_date'] = this.bookingDate;
    if (this.waypoints != null) {
      data['waypoints'] = this.waypoints!.map((v) => v.toJson()).toList();
    }
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
