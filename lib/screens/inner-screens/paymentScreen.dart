import 'package:bayoum_store_app/helper/AppPages.dart';
import 'package:bayoum_store_app/helper/fontthemes.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    bool payOnDelivery = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Options',
          style: CustomFontStyle.large,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment on delivery',
                  style: CustomFontStyle.medium.copyWith(color: Colors.black87),
                ),
                Switch(
                    activeColor: Colors.orange,
                    value: payOnDelivery,
                    onChanged: (value) {
                      setState(() {
                        payOnDelivery = value;
                      });
                      if (payOnDelivery) {
                        Navigator.pushNamed(context, AppPages.checkOutScreen);
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
