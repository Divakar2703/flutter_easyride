class NearByVehicle {
  final List<NearbyCab> vehicle;
  final String status;
  final String message;
  final int statusCode;

  NearByVehicle({
    required this.vehicle,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  factory NearByVehicle.fromJson(Map<String, dynamic> json) {
    return NearByVehicle(
      vehicle: (json['vehicle'] as List<dynamic>)
          .map((e) => NearbyCab.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      message: json['message'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle': vehicle.map((e) => e.toJson()).toList(),
      'status': status,
      'message': message,
      'statusCode': statusCode,
    };
  }
}

class NearbyCab {
  final String id;
  final String name;
  final String image;
  final String description;
  final String type;
  final String curr_lat;
  final String curr_long;


  NearbyCab({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.type,
    required this.curr_lat,
    required this.curr_long
  });

  factory NearbyCab.fromJson(Map<String, dynamic> json) {
    return NearbyCab(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      curr_lat: json['curr_lat'].toString(),
      curr_long: json["curr_long"].toString()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'type': type,
      'curr_lat':curr_lat,
      'curr_long':curr_long
    };
  }
}
