import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


// Navigation
void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void navigateAndRemove({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) {
      return false;
    },
  );
}




// Show toast message
void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { SUCCESS, WAENING, ERROR, NOTIFY }

Color chooseToastColor(ToastStates state) {
  late Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WAENING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.NOTIFY:
      color = Colors.grey;
      break;
  }
  return color;
}







