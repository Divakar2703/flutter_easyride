class PaymentGatewayModel {
  String? status;
  int? statusCode;
  String? message;
  List<PaymentGatewayDataModel>? data;

  PaymentGatewayModel({this.status, this.statusCode, this.message, this.data});

  PaymentGatewayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentGatewayDataModel>[];
      json['data'].forEach((v) {
        data!.add(new PaymentGatewayDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentGatewayDataModel {
  String? id;
  String? icon;
  String? name;
  String? value;
  String? credentials;

  PaymentGatewayDataModel({this.id, this.icon, this.name, this.value, this.credentials});

  PaymentGatewayDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    value = json['value'];
    credentials = json['credentials'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['value'] = this.value;
    data['credentials'] = this.credentials;
    return data;
  }
}
