import 'package:bayoum_store_app/controlller/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentServices {
  PaymentServices._();

  static PaymentServices paymentServices = PaymentServices._();
  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent('usd', 15);

      Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Abdelhaliem Adham',
          appearance: _paymentAppearance(),
        ),
      );

      await _proccessPayment();
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  PaymentSheetAppearance _paymentAppearance() {
    return const PaymentSheetAppearance(
      colors: PaymentSheetAppearanceColors(
        background: Colors.lightBlue,
        primary: Colors.blue,
        componentBorder: Colors.red,
      ),
      shapes: PaymentSheetShape(
        borderWidth: 4,
        shadow: PaymentSheetShadowParams(color: Colors.red),
      ),
      primaryButton: PaymentSheetPrimaryButtonAppearance(
        shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
        colors: PaymentSheetPrimaryButtonTheme(
          light: PaymentSheetPrimaryButtonThemeColors(
            background: Color.fromARGB(255, 231, 235, 30),
            text: Color.fromARGB(255, 235, 92, 30),
            border: Color.fromARGB(255, 235, 92, 30),
          ),
        ),
      ),
    );
  }

  Future<String?> _createPaymentIntent(String currency, int amount) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": (amount * 100).toString(),
        "currency": currency,
      };
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_methods',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data) {
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
    return null;
  }

  Future<void> _proccessPayment() async {
    await Stripe.instance.presentPaymentSheet();
  }
}
