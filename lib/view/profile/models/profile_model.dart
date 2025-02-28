class ProfileModel {
  String? status;
  int? statusCode;
  String? message;
  ProfileDataModel? data;

  ProfileModel({this.status, this.statusCode, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new ProfileDataModel.fromJson(json['data']) : null;
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

class ProfileDataModel {
  String? id;
  String? userId;
  String? name;
  String? mobile;
  String? email;
  String? walletAmount;

  ProfileDataModel({this.id, this.userId, this.name, this.mobile, this.email, this.walletAmount});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    walletAmount = json['wallet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['wallet_amount'] = this.walletAmount;
    return data;
  }
}
