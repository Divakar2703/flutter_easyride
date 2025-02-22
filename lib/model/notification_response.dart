// RideResponse Model Class
class NotificationResponse {
  final List<Notifications> list;
  final int nextPage;
  final String status;
  final int statusCode;
  final String message;

  NotificationResponse({
    required this.list,
    required this.nextPage,
    required this.status,
    required this.statusCode,
    required this.message,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      list: (json['list'] as List).map((item) => Notifications.fromJson(item)).toList(),
      nextPage: json['nextpage'],
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((ride) => ride.toJson()).toList(),
      'nextpage': nextPage,
      'status': status,
      'statusCode': statusCode,
      'message': message,
    };
  }
}

// Ride Model Class
class Notifications {
  final String id;
  final String bookId;
  final String bookingType;
  final String pickupAddress;
  final String dropAddress;
  final String vehicle;
  final String userJourneyDistance;
  final String totalFare;
  final String totalWaitCharge;
  final String grandTotal;
  final String? selectedTime;
  final String? selectedDate;
  final String paymentType;
  final String userName;
  final String userMobile;
  final String userEmail;
  final String rideStatus;
  final String paymentStatus;
  final String isCancel;
  final String cancelDate;
  final String cancelReason;
  final String entryDate;

  Notifications({
    required this.id,
    required this.bookId,
    required this.bookingType,
    required this.pickupAddress,
    required this.dropAddress,
    required this.vehicle,
    required this.userJourneyDistance,
    required this.totalFare,
    required this.totalWaitCharge,
    required this.grandTotal,
    this.selectedTime,
    this.selectedDate,
    required this.paymentType,
    required this.userName,
    required this.userMobile,
    required this.userEmail,
    required this.rideStatus,
    required this.paymentStatus,
    required this.isCancel,
    required this.cancelDate,
    required this.cancelReason,
    required this.entryDate,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      bookId: json['book_id'],
      bookingType: json['booking_type'],
      pickupAddress: json['pickup_address'],
      dropAddress: json['drop_address'],
      vehicle: json['vehicle'],
      userJourneyDistance: json['user_journey_distance'],
      totalFare: json['total_fare'],
      totalWaitCharge: json['total_wait_charge'],
      grandTotal: json['grand_total'],
      selectedTime: json['selectedtime'],
      selectedDate: json['selecteddate'],
      paymentType: json['paymenttype'],
      userName: json['user_name'],
      userMobile: json['user_mobile'],
      userEmail: json['user_email'],
      rideStatus: json['ride_status'],
      paymentStatus: json['payment_status'],
      isCancel: json['is_cancle'],
      cancelDate: json['cancle_date'],
      cancelReason: json['cancle_reason'],
      entryDate: json['entry_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_id': bookId,
      'booking_type': bookingType,
      'pickup_address': pickupAddress,
      'drop_address': dropAddress,
      'vehicle': vehicle,
      'user_journey_distance': userJourneyDistance,
      'total_fare': totalFare,
      'total_wait_charge': totalWaitCharge,
      'grand_total': grandTotal,
      'selectedtime': selectedTime,
      'selecteddate': selectedDate,
      'paymenttype': paymentType,
      'user_name': userName,
      'user_mobile': userMobile,
      'user_email': userEmail,
      'ride_status': rideStatus,
      'payment_status': paymentStatus,
      'is_cancle': isCancel,
      'cancle_date': cancelDate,
      'cancle_reason': cancelReason,
      'entry_date': entryDate,
    };
  }
}
