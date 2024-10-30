class HistoryDetails {
  final String? id;
  final String? bookId;
  final String? pickupAddress;
  final String? pickupLat;
  final String? pickupLong;
  final String? dropAddress;
  final String? dropLat;
  final String? dropLong;
  final String? vehicle;
  final String? vehicleImage;
  final String? userJourneyDistance;
  final String? totalFare;
  final String? totalWaitCharge;
  final String? grandTotal;
  final String? driverName;
  final String? driverImg;
  final String? rideStatus;
  final String? paymentStatus;
  final String? isCancle;
  final String? paymentType;
  final String? cancleDate;
  final String? cancleReason;
  final String? entryDate;
  final String? deliveryBoyMobileNo;
  final String? isArrive;
  final String? convCharge;
  final String? postPaymentType;
  final String? finalGrandTotal;
  final String? isArrivedDestination;
  final String? vehicleNumber;
  final String? status;
  final int? statusCode;
  final String? message;

  HistoryDetails({
    this.id,
    this.bookId,
    this.pickupAddress,
    this.pickupLat,
    this.pickupLong,
    this.dropAddress,
    this.dropLat,
    this.dropLong,
    this.vehicle,
    this.vehicleImage,
    this.userJourneyDistance,
    this.totalFare,
    this.totalWaitCharge,
    this.grandTotal,
    this.driverName,
    this.driverImg,
    this.rideStatus,
    this.paymentStatus,
    this.isCancle,
    this.paymentType,
    this.cancleDate,
    this.cancleReason,
    this.entryDate,
    this.deliveryBoyMobileNo,
    this.isArrive,
    this.convCharge,
    this.postPaymentType,
    this.finalGrandTotal,
    this.isArrivedDestination,
    this.vehicleNumber,
    this.status,
    this.statusCode,
    this.message,
  });

  factory HistoryDetails.fromJson(Map<String, dynamic> json) {
    return HistoryDetails(
      id: json['id'],
      bookId: json['book_id'],
      pickupAddress: json['pickup_address'],
      pickupLat: json['pickup_lat'],
      pickupLong: json['pickup_long'],
      dropAddress: json['drop_address'],
      dropLat: json['drop_lat'],
      dropLong: json['drop_long'],
      vehicle: json['vehicle'],
      vehicleImage: json['vehicle_image'],
      userJourneyDistance: json['user_journey_distance'],
      totalFare: json['total_fare'],
      totalWaitCharge: json['total_wait_charge'],
      grandTotal: json['grand_total'],
      driverName: json['driver_name'],
      driverImg: json['driver_img'],
      rideStatus: json['ride_status'],
      paymentStatus: json['payment_status'],
      isCancle: json['is_cancle'],
      paymentType: json['paymenttype'],
      cancleDate: json['cancle_date'],
      cancleReason: json['cancle_reason'],
      entryDate: json['entry_date'],
      deliveryBoyMobileNo: json['deliveryboy_mobileno'],
      isArrive: json['is_arrive'],
      convCharge: json['conv_charge'],
      postPaymentType: json['post_paymenttype'],
      finalGrandTotal: json['final_grandtotal'],
      isArrivedDestination: json['is_arrived_destination'],
      vehicleNumber: json['vehical_number'],
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
