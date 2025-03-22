class WalletHistoryModel {
  String? status;
  int? statusCode;
  String? message;
  WalletHistoryDataModel? data;

  WalletHistoryModel({this.status, this.statusCode, this.message, this.data});

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new WalletHistoryDataModel.fromJson(json['data']) : null;
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

class WalletHistoryDataModel {
  String? walletAmount;
  List<Filters>? filters;
  List<HistoryList>? historyList;

  WalletHistoryDataModel({this.walletAmount, this.historyList});

  WalletHistoryDataModel.fromJson(Map<String, dynamic> json) {
    walletAmount = json['wallet_amount'];
    if (json['filters'] != null) {
      filters = <Filters>[];
      json['filters'].forEach((v) {
        filters!.add(new Filters.fromJson(v));
      });
    }
    if (json['history_list'] != null) {
      historyList = <HistoryList>[];
      json['history_list'].forEach((v) {
        historyList!.add(new HistoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }
    data['wallet_amount'] = this.walletAmount;
    if (this.historyList != null) {
      data['history_list'] = this.historyList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Filters {
  String? title;
  String? value;
  List<FilterModel>? data;

  Filters({this.title, this.value, this.data});

  Filters.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    if (json['data'] != null) {
      data = <FilterModel>[];
      json['data'].forEach((v) {
        data!.add(new FilterModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterModel {
  String? value;
  String? title;
  bool isSelected = false;

  FilterModel({this.value, this.title});

  FilterModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['title'] = this.title;
    return data;
  }
}

class HistoryList {
  String? id;
  String? userId;
  String? paymentId;
  String? transactionType;
  String? amount;
  String? openingBalance;
  String? closingBalance;
  String? description;
  String? createdAt;

  HistoryList(
      {this.id,
      this.userId,
      this.paymentId,
      this.transactionType,
      this.amount,
      this.openingBalance,
      this.closingBalance,
      this.description,
      this.createdAt});

  HistoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentId = json['payment_id'];
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
    data['payment_id'] = this.paymentId;
    data['transaction_type'] = this.transactionType;
    data['amount'] = this.amount;
    data['opening_balance'] = this.openingBalance;
    data['closing_balance'] = this.closingBalance;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
