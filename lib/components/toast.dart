import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
Future<bool?> toast(String message) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 15.0);
}

// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
