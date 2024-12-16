class Booking {
  final String id;
  final String bookId;
  final String bookingType;
  final String pickupAddress;
  final String dropAddress;
  final String userJourneyDistance;
  final String totalFare;
  // final String totalWaitCharge;
  final String grandTotal;
  // final String? selectedTime;
  // final String? selectedDate;
  // final String paymentType;
  final String userName;
  final String userMobile;
  final String userEmail;
  final String drop_lat;
  final String drop_long;
  final String rideStatus;
   final String paymentStatus;
  // final String isCancel;
  // final String cancelDate;
  // final String cancelReason;
  final String entryDate;

  Booking({
    required this.id,
    required this.bookId,
    required this.bookingType,
    required this.pickupAddress,
    required this.dropAddress,
    required this.userJourneyDistance,
    required this.totalFare,
    // required this.totalWaitCharge,
    required this.grandTotal,
    // this.selectedTime,
    // this.selectedDate,
    // required this.paymentType,
    required this.userName,
    required this.userMobile,
    required this.userEmail,
    required this.drop_lat,
    required this.drop_long,
    required this.rideStatus,
    required this.paymentStatus,
    // required this.isCancel,
    // required this.cancelDate,
    // required this.cancelReason,
    required this.entryDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      bookId: json['book_id'],
      bookingType: json['booking_type'].toString(),
      pickupAddress: json['pickup_address'].toString(),
      dropAddress: json['drop_address'].toString(),
      userJourneyDistance: json['user_journey_distance'].toString(),
      totalFare: json['total_fare'].toString(),
      // totalWaitCharge: json['total_wait_charge'],
      grandTotal: json['grand_total'].toString(),
      // selectedTime: json['selectedtime'],
      // selectedDate: json['selecteddate'],
      // paymentType: json['paymenttype'],
      userName: json['user_name'],
      userMobile: json['user_mobile'],
      userEmail: json['user_email'],
      drop_lat: json['drop_lat'].toString(),
      drop_long: json['drop_long'].toString(),
      rideStatus: json['ride_status'].toString(),
      paymentStatus: json['payment_status'],
      // isCancel: json['is_cancle'],
      // cancelDate: json['cancle_date'],
      // cancelReason: json['cancle_reason'],
      entryDate: json['entry_date'].toString(),
    );
  }
}
