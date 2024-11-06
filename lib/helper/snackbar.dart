import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFun {
  static showSnackBarWidegt(
    String message,
    String title,
  ) {
    return Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          title,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        snackPosition: SnackPosition.TOP,
        shouldIconPulse: true,
        showProgressIndicator: true,
        messageText: Text(
          message,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        icon: const Icon(Icons.message, color: Colors.white, size: 35),
        backgroundColor: Colors.deepOrange,
        duration: const Duration(seconds: 3),
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
