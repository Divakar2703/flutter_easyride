class CabPaymentResponseModel {
  final String? orderId;
  final String? orderNo;
  final String? txnAmount;
  final String? custId;
  final String? resCode;
  final String? mainAmount;
  final String? vpaid;
  final String? status;
  final String? convCharge;
  final String? custRefNo;

  CabPaymentResponseModel({
    this.orderId,
    this.orderNo,
    this.txnAmount,
    this.custId,
    this.resCode,
    this.mainAmount,
    this.vpaid,
    this.status,
    this.convCharge,
    this.custRefNo,
  });

  // Factory constructor to create an instance from JSON
  factory CabPaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return CabPaymentResponseModel(
      orderId: json['ORDER_ID'] as String?,
      orderNo: json['orderno'] as String?,
      txnAmount: json['TXN_AMOUNT'] as String?,
      custId: json['CUST_ID'] as String?,
      resCode: json['res_code'] as String?,
      mainAmount: json['MAIN_AMOUNT'] as String?,
      vpaid: json['vpaid'] as String?,
      status: json['status'] as String?,
      convCharge: json['CONV_CHARGE'] as String?,
      custRefNo: json['cust_ref_no'] as String?,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'ORDER_ID': orderId,
      'orderno': orderNo,
      'TXN_AMOUNT': txnAmount,
      'CUST_ID': custId,
      'res_code': resCode,
      'MAIN_AMOUNT': mainAmount,
      'vpaid': vpaid,
      'status': status,
      'CONV_CHARGE': convCharge,
      'cust_ref_no': custRefNo,
    };
  }
}
