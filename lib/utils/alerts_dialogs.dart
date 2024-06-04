import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert {
  static showSnackBar({title, msg}) async {
    Get.snackbar(title, msg, backgroundColor: Colors.white70);
  }
}
