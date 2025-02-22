import 'dart:convert';

class DashboardResponse {
  List<BannerItem> banner;
  List<StatusItem> bookNow;
  List<StatusItem> preBooking;
  List<StatusItem> rental;
  String status;
  String message;
  int statusCode;

  DashboardResponse({
    required this.banner,
    required this.bookNow,
    required this.preBooking,
    required this.rental,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      banner: (json['banner'] as List<dynamic>)
          .map((item) => BannerItem.fromJson(item))
          .toList(),
      bookNow: (json['book_now'] as List<dynamic>)
          .map((item) => StatusItem.fromJson(item))
          .toList(),
      preBooking: (json['pre_booking'] as List<dynamic>)
          .map((item) => StatusItem.fromJson(item))
          .toList(),
      rental: (json['rental'] as List<dynamic>)
          .map((item) => StatusItem.fromJson(item))
          .toList(),
      status: json['status'],
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner': banner.map((item) => item.toJson()).toList(),
      'book_now': bookNow.map((item) => item.toJson()).toList(),
      'pre_booking': preBooking.map((item) => item.toJson()).toList(),
      'rental': rental.map((item) => item.toJson()).toList(),
      'status': status,
      'message': message,
      'statusCode': statusCode,
    };
  }
}

class BannerItem {
  String id;
  String bannerName;
  String appBannerImage;
  String link;
  String status;

  BannerItem({
    required this.id,
    required this.bannerName,
    required this.appBannerImage,
    required this.link,
    required this.status,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'],
      bannerName: json['banner_name'],
      appBannerImage: json['appbanner_image'],
      link: json['link'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'banner_name': bannerName,
      'appbanner_image': appBannerImage,
      'link': link,
      'status': status,
    };
  }
}

class StatusItem {
  String status;

  StatusItem({required this.status});

  factory StatusItem.fromJson(Map<String, dynamic> json) {
    return StatusItem(
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
