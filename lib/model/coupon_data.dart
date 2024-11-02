class CouponData {
  final List<Coupon> coupon;
  final String status;
  final String message;
  final int statusCode;

  CouponData({
    required this.coupon,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  // Factory method to create a VehicleResponse object from JSON
  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      coupon: (json['vehicle'] as List)
          .map((vehicle) => Coupon.fromJson(vehicle))
          .toList(),
      status: json['status'] as String,
      message: json['message'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  // Method to convert a VehicleResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'vehicle': coupon.map((v) => v.toJson()).toList(),
      'status': status,
      'message': message,
      'statusCode': statusCode,
    };
  }
}

class Coupon {
  final String couponId;
  final String promocodeImg;
  final String promoCode;
  final String promoCodeDescription;
  final String promoCodeDiscount;
  final String startDate;
  final String expiryDate;
  final String couponStatus;
  final double fare;
  final double discount;
  final double netFare;

  Coupon({
    required this.couponId,
    required this.promocodeImg,
    required this.promoCode,
    required this.promoCodeDescription,
    required this.promoCodeDiscount,
    required this.startDate,
    required this.expiryDate,
    required this.couponStatus,
    required this.fare,
    required this.discount,
    required this.netFare,
  });

  // Factory method to create a Vehicle object from JSON
  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponId: json['coupon_id'] as String,
      promocodeImg: json['promocode_img'] as String,
      promoCode: json['promo_code'] as String,
      promoCodeDescription: json['promo_code_discription'] as String,
      promoCodeDiscount: json['promo_code_discount'] as String,
      startDate: json['start_date'] as String,
      expiryDate: json['expiry_date'] as String,
      couponStatus: json['coupon_status'] as String,
      fare: (json['fare'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      netFare: (json['net_fare'] as num).toDouble(),
    );
  }

  // Method to convert a Vehicle object to JSON
  Map<String, dynamic> toJson() {
    return {
      'coupon_id': couponId,
      'promocode_img': promocodeImg,
      'promo_code': promoCode,
      'promo_code_discription': promoCodeDescription,
      'promo_code_discount': promoCodeDiscount,
      'start_date': startDate,
      'expiry_date': expiryDate,
      'coupon_status': couponStatus,
      'fare': fare,
      'discount': discount,
      'net_fare': netFare,
    };
  }
}

