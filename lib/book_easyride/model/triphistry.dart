import 'dart:convert';

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
    final String? item;
  TripHistory({
    this.item,
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


//  Check Histry Model  





History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
    List<ListElement> list;
    int nextpage;
    String status;
    int statusCode;
    String message;

    History({
        required this.list,
        required this.nextpage,
        required this.status,
        required this.statusCode,
        required this.message,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
        nextpage: json["nextpage"],
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "nextpage": nextpage,
        "status": status,
        "statusCode": statusCode,
        "message": message,
    };
}

class ListElement {
    String id;
    String bookId;
    String pickupAddress;
    String dropAddress;
    Vehicle vehicle;
    String vehicleImage;
    String userJourneyDistance;
    String totalFare;
    String totalWaitCharge;
    String grandTotal;
    RideStatus rideStatus;
    PaymentStatus paymentStatus;
    String isCancle;
    CancleDate cancleDate;
    String cancleReason;
    String entryDate;
    String isArrivedDestination;

    ListElement({
        required this.id,
        required this.bookId,
        required this.pickupAddress,
        required this.dropAddress,
        required this.vehicle,
        required this.vehicleImage,
        required this.userJourneyDistance,
        required this.totalFare,
        required this.totalWaitCharge,
        required this.grandTotal,
        required this.rideStatus,
        required this.paymentStatus,
        required this.isCancle,
        required this.cancleDate,
        required this.cancleReason,
        required this.entryDate,
        required this.isArrivedDestination,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        bookId: json["book_id"],
        pickupAddress: json["pickup_address"],
        dropAddress: json["drop_address"],
        vehicle: vehicleValues.map[json["vehicle"]]!,
        vehicleImage: json["vehicle_image"],
        userJourneyDistance: json["user_journey_distance"],
        totalFare: json["total_fare"],
        totalWaitCharge: json["total_wait_charge"],
        grandTotal: json["grand_total"],
        rideStatus: rideStatusValues.map[json["ride_status"]]!,
        paymentStatus: paymentStatusValues.map[json["payment_status"]]!,
        isCancle: json["is_cancle"],
        cancleDate: cancleDateValues.map[json["cancle_date"]]!,
        cancleReason: json["cancle_reason"],
        entryDate: json["entry_date"],
        isArrivedDestination: json["is_arrived_destination"],
    );

  get bookingId => null;

    Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "pickup_address": pickupAddress,
        "drop_address": dropAddress,
        "vehicle": vehicleValues.reverse[vehicle],
        "vehicle_image": vehicleImage,
        "user_journey_distance": userJourneyDistance,
        "total_fare": totalFare,
        "total_wait_charge": totalWaitCharge,
        "grand_total": grandTotal,
        "ride_status": rideStatusValues.reverse[rideStatus],
        "payment_status": paymentStatusValues.reverse[paymentStatus],
        "is_cancle": isCancle,
        "cancle_date": cancleDateValues.reverse[cancleDate],
        "cancle_reason": cancleReason,
        "entry_date": entryDate,
        "is_arrived_destination": isArrivedDestination,
    };
}

enum CancleDate {
    THE_00000000000000
}

final cancleDateValues = EnumValues({
    "0000-00-00 00:00:00": CancleDate.THE_00000000000000
});

enum PaymentStatus {
    PAID,
    PENDING
}

final paymentStatusValues = EnumValues({
    "Paid": PaymentStatus.PAID,
    "Pending": PaymentStatus.PENDING
});

enum RideStatus {
    COMPLETED,
    PENDING,
    START
}

final rideStatusValues = EnumValues({
    "Completed": RideStatus.COMPLETED,
    "Pending": RideStatus.PENDING,
    "Start": RideStatus.START
});

enum Vehicle {
    BIKE,
    TESLA
}

final vehicleValues = EnumValues({
    "Bike": Vehicle.BIKE,
    "Tesla": Vehicle.TESLA
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
