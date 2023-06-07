import 'package:fluttertoast/fluttertoast.dart';

toast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    fontSize: 16,
  );
}
