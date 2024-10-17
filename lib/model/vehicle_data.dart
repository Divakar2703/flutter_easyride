class VehicleResponse {
  final List<Vehicle> vehicle;
  final String status;
  final String message;
  final int statusCode;

  VehicleResponse({
    required this.vehicle,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  // Factory method to create a VehicleResponse object from JSON
  factory VehicleResponse.fromJson(Map<String, dynamic> json) {
    return VehicleResponse(
      vehicle: (json['vehicle'] as List)
          .map((vehicle) => Vehicle.fromJson(vehicle))
          .toList(),
      status: json['status'] as String,
      message: json['message'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  // Method to convert a VehicleResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'vehicle': vehicle.map((v) => v.toJson()).toList(),
      'status': status,
      'message': message,
      'statusCode': statusCode,
    };
  }
}

class Vehicle {
  final String id;
  final String name;
  final String image;
  final String description;
  final double fare;

  Vehicle({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.fare,
  });

  // Factory method to create a Vehicle object from JSON
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      fare: (json['fare'] as num).toDouble(),
    );
  }

  // Method to convert a Vehicle object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'fare': fare,
    };
  }
}
