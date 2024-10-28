import 'dart:convert';

TripHistryDetailsModel tripHistryDetailsModelFromJson(String str) =>
    TripHistryDetailsModel.fromJson(json.decode(str));

String tripHistryDetailsModelToJson(TripHistryDetailsModel data) =>
    json.encode(data.toJson());

class TripHistryDetailsModel {
  List<TripHistryDetailsModel>? trip;
  String? id;
  String? bookId;
  String? pickupAddress;
  String? pickupLat;
  String? pickupLong;
  String? dropAddress;
  String? dropLat;
  String? dropLong;
  String? vehicle;
  String? vehicleImage;
  String? userJourneyDistance;
  String? totalFare;
  String? totalWaitCharge;
  String? grandTotal;
  String? driverName;
  String? driverImg;
  String? rideStatus;
  String? paymentStatus;
  String? isCancel;
  String? paymenttype;
  String? cancelDate;
  String? cancelReason;
  String? entryDate;
  String? deliveryboyMobileNo;
  String? isArrive;
  String? convCharge;
  String? postPaymentType;
  String? finalGrandTotal;
  String? isArrivedDestination;
  String? vehicleNumber;
  String? status;
  int? statusCode;
  String? message;



  TripHistryDetailsModel({
    this.trip,
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
    this.isCancel,
    this.paymenttype,
    this.cancelDate,
    this.cancelReason,
    this.entryDate,
    this.deliveryboyMobileNo,
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

  factory TripHistryDetailsModel.fromJson(Map<String, dynamic> json) =>
      TripHistryDetailsModel(
        id: json["id"],
        bookId: json["book_id"],
        pickupAddress: json["pickup_address"],
        pickupLat: json["pickup_lat"],
        pickupLong: json["pickup_long"],
        dropAddress: json["drop_address"],
        dropLat: json["drop_lat"],
        dropLong: json["drop_long"],
        vehicle: json["vehicle"],
        vehicleImage: json["vehicle_image"],
        userJourneyDistance: json["user_journey_distance"],
        totalFare: json["total_fare"],
        totalWaitCharge: json["total_wait_charge"],
        grandTotal: json["grand_total"],
        driverName: json["driver_name"],
        driverImg: json["driver_img"],
        rideStatus: json["ride_status"],
        paymentStatus: json["payment_status"],
        isCancel: json["is_cancel"],
        paymenttype: json["payment_type"],
        cancelDate: json["cancel_date"],
        cancelReason: json["cancel_reason"],
        entryDate: json["entry_date"],
        deliveryboyMobileNo: json["deliveryboy_mobile_no"],
        isArrive: json["is_arrive"],
        convCharge: json["conv_charge"],
        postPaymentType: json["post_payment_type"],
        finalGrandTotal: json["final_grand_total"],
        isArrivedDestination: json["is_arrived_destination"],
        vehicleNumber: json["vehicle_number"],
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "pickup_address": pickupAddress,
        "pickup_lat": pickupLat,
        "pickup_long": pickupLong,
        "drop_address": dropAddress,
        "drop_lat": dropLat,
        "drop_long": dropLong,
        "vehicle": vehicle,
        "vehicle_image": vehicleImage,
        "user_journey_distance": userJourneyDistance,
        "total_fare": totalFare,
        "total_wait_charge": totalWaitCharge,
        "grand_total": grandTotal,
        "driver_name": driverName,
        "driver_img": driverImg,
        "ride_status": rideStatus,
        "payment_status": paymentStatus,
        "is_cancel": isCancel,
        "payment_type": paymenttype,
        "cancel_date": cancelDate,
        "cancel_reason": cancelReason,
        "entry_date": entryDate,
        "deliveryboy_mobile_no": deliveryboyMobileNo,
        "is_arrive": isArrive,
        "conv_charge": convCharge,
        "post_payment_type": postPaymentType,
        "final_grand_total": finalGrandTotal,
        "is_arrived_destination": isArrivedDestination,
        "vehicle_number": vehicleNumber,
        "status": status,
        "status_code": statusCode,
        "message": message,
      };
}
