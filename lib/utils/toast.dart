import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
