import 'package:get/get.dart';
import 'package:flutter/material.dart';

mySnackBar(title, message, type) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: type == true ? Colors.blue : Colors.red,
    colorText: Colors.white,
  );
}
