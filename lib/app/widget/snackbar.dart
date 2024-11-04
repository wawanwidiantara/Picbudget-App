import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarWidget {
  static void showSnackBar(String title, String conntent, String tipe) {
    Get.snackbar(title, conntent,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
        backgroundColor: tipe == "err" ? Colors.red : Colors.green);
  }
}
