class SaveRideModel {
  String? status;
  int? statusCode;
  String? message;
  SaveRideDataModel? data;

  SaveRideModel({this.status, this.statusCode, this.message, this.data});

  SaveRideModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new SaveRideDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SaveRideDataModel {
  int? vehicleTypeId;
  int? reqId;

  SaveRideDataModel({this.vehicleTypeId, this.reqId});

  SaveRideDataModel.fromJson(Map<String, dynamic> json) {
    vehicleTypeId = json['vehicle_type_id'];
    reqId = json['req_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['req_id'] = this.reqId;
    return data;
  }
}
