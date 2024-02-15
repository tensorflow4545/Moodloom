import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String note) {
  Get.snackbar(
    instantInit: true,
    isDismissible: true,
    note,
    'error',
    snackPosition: SnackPosition.TOP, // Change position if needed
    duration: Duration(seconds: 1), // Adjust the duration
    backgroundColor: Colors.white.withOpacity(0.1), // Set background color
    colorText: Colors.white, // Set text color
  );
}
