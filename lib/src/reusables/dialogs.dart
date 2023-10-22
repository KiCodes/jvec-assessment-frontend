import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class CustomDialog {

  void showCustomToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 18
    );
  }

}