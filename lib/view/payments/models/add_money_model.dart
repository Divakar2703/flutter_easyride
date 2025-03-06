class AddMoneyModel {
  String? status;
  int? statusCode;
  String? message;
  AddMoneyDataModel? data;

  AddMoneyModel({this.status, this.statusCode, this.message, this.data});

  AddMoneyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new AddMoneyDataModel.fromJson(json['data']) : null;
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

class AddMoneyDataModel {
  String? status;
  String? orderId;
  int? amount;
  String? currency;
  String? message;

  AddMoneyDataModel({this.status, this.orderId, this.amount, this.currency, this.message});

  AddMoneyDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderId = json['order_id'];
    amount = json['amount'];
    currency = json['currency'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['message'] = this.message;
    return data;
  }
}
