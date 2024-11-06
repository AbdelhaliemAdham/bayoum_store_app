import 'dart:math';

import 'package:get/get.dart';

class MyMath extends GetxController {
  double randomNumber = 0.0;

  getRandomNumber() {
    Random random = Random();
    randomNumber = random.nextDouble() * 50 + 1;
    // Generates a number from 0 to 49, then adds 1
  }

  String getFormatedAmount(double totalAmount) {
    double randomDeduction = randomNumber;
    double finalAmount = (totalAmount - randomDeduction);
    String formattedAmount = finalAmount.toInt().toString();
    String displayAmount = "\$ $formattedAmount";

    return displayAmount;
  }
}
