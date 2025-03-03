class WalletHistoryModel {
  String? status;
  int? statusCode;
  String? message;
  List<WalletHistoryDataModel>? data;

  WalletHistoryModel({this.status, this.statusCode, this.message, this.data});

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WalletHistoryDataModel>[];
      json['data'].forEach((v) {
        data!.add(new WalletHistoryDataModel.fromJson(v));
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

class WalletHistoryDataModel {
  String? id;
  String? userId;
  String? transactionType;
  String? amount;
  String? openingBalance;
  String? closingBalance;
  String? description;
  String? createdAt;

  WalletHistoryDataModel(
      {this.id,
      this.userId,
      this.transactionType,
      this.amount,
      this.openingBalance,
      this.closingBalance,
      this.description,
      this.createdAt});

  WalletHistoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionType = json['transaction_type'];
    amount = json['amount'];
    openingBalance = json['opening_balance'];
    closingBalance = json['closing_balance'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['transaction_type'] = this.transactionType;
    data['amount'] = this.amount;
    data['opening_balance'] = this.openingBalance;
    data['closing_balance'] = this.closingBalance;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
