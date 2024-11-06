import 'package:bayoum_store_app/helper/assets.dart';
import 'package:flutter/material.dart';

class InternetLostScreen extends StatefulWidget {
  const InternetLostScreen({super.key});

  @override
  State<InternetLostScreen> createState() => _InternetLostScreenState();
}

class _InternetLostScreenState extends State<InternetLostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                Assets.noConnection,
                width: 150,
                height: 150,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: Text(
                'There is no internet connection',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
