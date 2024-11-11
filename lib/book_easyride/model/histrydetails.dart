import 'dart:convert';

TripHistryModel tripHistryModelFromJson(String str) => TripHistryModel.fromJson(json.decode(str));

String tripHistryModelToJson(TripHistryModel data) => json.encode(data.toJson());

class TripHistryModel {
    String id;
    String bookId;
    String pickupAddress;
    String pickupLat;
    String pickupLong;
    String dropAddress;
    String dropLat;
    String dropLong;
    String vehicle;
    String vehicleImage;
    String userJourneyDistance;
    String totalFare;
    String totalWaitCharge;
    String grandTotal;
    String driverName;
    String driverImg;
    String rideStatus;
    String paymentStatus;
    String isCancle;
    String paymenttype;
    String cancleDate;
    String cancleReason;
    String entryDate;
    String deliveryboyMobileno;
    String isArrive;
    String convCharge;
    String postPaymenttype;
    String finalGrandtotal;
    String isArrivedDestination;
    String vehicalNumber;
    String status;
    int statusCode;
    String message;

    TripHistryModel({
        required this.id,
        required this.bookId,
        required this.pickupAddress,
        required this.pickupLat,
        required this.pickupLong,
        required this.dropAddress,
        required this.dropLat,
        required this.dropLong,
        required this.vehicle,
        required this.vehicleImage,
        required this.userJourneyDistance,
        required this.totalFare,
        required this.totalWaitCharge,
        required this.grandTotal,
        required this.driverName,
        required this.driverImg,
        required this.rideStatus,
        required this.paymentStatus,
        required this.isCancle,
        required this.paymenttype,
        required this.cancleDate,
        required this.cancleReason,
        required this.entryDate,
        required this.deliveryboyMobileno,
        required this.isArrive,
        required this.convCharge,
        required this.postPaymenttype,
        required this.finalGrandtotal,
        required this.isArrivedDestination,
        required this.vehicalNumber,
        required this.status,
        required this.statusCode,
        required this.message,
    });

    factory TripHistryModel.fromJson(Map<String, dynamic> json) => TripHistryModel(
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
        isCancle: json["is_cancle"],
        paymenttype: json["paymenttype"],
        cancleDate: json["cancle_date"],
        cancleReason: json["cancle_reason"],
        entryDate: json["entry_date"],
        deliveryboyMobileno: json["deliveryboy_mobileno"],
        isArrive: json["is_arrive"],
        convCharge: json["conv_charge"],
        postPaymenttype: json["post_paymenttype"],
        finalGrandtotal: json["final_grandtotal"],
        isArrivedDestination: json["is_arrived_destination"],
        vehicalNumber: json["vehical_number"],
        status: json["status"],
        statusCode: json["statusCode"],
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
        "is_cancle": isCancle,
        "paymenttype": paymenttype,
        "cancle_date": cancleDate,
        "cancle_reason": cancleReason,
        "entry_date": entryDate,
        "deliveryboy_mobileno": deliveryboyMobileno,
        "is_arrive": isArrive,
        "conv_charge": convCharge,
        "post_paymenttype": postPaymenttype,
        "final_grandtotal": finalGrandtotal,
        "is_arrived_destination": isArrivedDestination,
        "vehical_number": vehicalNumber,
        "status": status,
        "statusCode": statusCode,
        "message": message,
    };
}

