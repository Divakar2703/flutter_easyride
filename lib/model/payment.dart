import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));
String paymentToJson(Payment data) => json.encode(data.toJson());
class Payment {
    int status;
    String convCharge;
    String codSts;
    bool onlineSts;
    bool razorpaySts;
    String message;

    Payment({
        required this.status,
        required this.convCharge,
        required this.codSts,
        required this.onlineSts,
        required this.razorpaySts,
        required this.message,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        status: json["status"],
        convCharge: json["conv_charge"],
        codSts: json["cod_sts"],
        onlineSts: json["online_sts"],
        razorpaySts: json["razorpay_sts"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "conv_charge": convCharge,
        "cod_sts": codSts,
        "online_sts": onlineSts,
        "razorpay_sts": razorpaySts,
        "message": message,
    };
}
