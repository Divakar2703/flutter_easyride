class Histrydetailsmodel {
  final int tripId;
  final String driverName;
  final String data;
  final String tripDuration;

  Histrydetailsmodel({
    required this.tripId,
    required this.driverName,
    required this.data,
    required this.tripDuration,
  });

  factory Histrydetailsmodel.formjson(Map<String, dynamic> json) {
    return Histrydetailsmodel(
        tripId: json['trip_id'],
        driverName: json['driver_name'],
        data: json['date'],
        tripDuration: json['trip_duration']);
  }
}
