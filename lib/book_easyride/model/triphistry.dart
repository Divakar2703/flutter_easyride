class TripHistory {
  final String? id;
  final String? bookId;
  final String? pickupAddress;
  final String? dropAddress;
  final String? vehicle;
  final String? vehicleImage;
  final String? userJourneyDistance;
  final String? totalFare;
  final String? totalWaitCharge;
  final String? grandTotal;
  final String? rideStatus;
  final String? paymentStatus;
  final String? isCancel;
  final String? cancelDate;
  final String? cancelReason;
  final String? entryDate;
  final String? isArrivedDestination;

  TripHistory({
    this.id,
    this.bookId,
    this.pickupAddress,
    this.dropAddress,
    this.vehicle,
    this.vehicleImage,
    this.userJourneyDistance,
    this.totalFare,
    this.totalWaitCharge,
    this.grandTotal,
    this.rideStatus,
    this.paymentStatus,
    this.isCancel,
    this.cancelDate,
    this.cancelReason,
    this.entryDate,
    this.isArrivedDestination,
  });

  factory TripHistory.fromJson(Map<String, dynamic> json) {
    return TripHistory(
      id: json['id'],
      bookId: json['book_id'],
      pickupAddress: json['pickup_address'],
      dropAddress: json['drop_address'],
      vehicle: json['vehicle'],
      vehicleImage: json['vehicle_image'],
      userJourneyDistance: json['user_journey_distance'],
      totalFare: json['total_fare'],
      totalWaitCharge: json['total_wait_charge'],
      grandTotal: json['grand_total'],
      rideStatus: json['ride_status'],
      paymentStatus: json['payment_status'],
      isCancel: json['is_cancle'],
      cancelDate: json['cancle_date'],
      cancelReason: json['cancle_reason'],
      entryDate: json['entry_date'],
      isArrivedDestination: json['is_arrived_destination'],
    );
  }
}
