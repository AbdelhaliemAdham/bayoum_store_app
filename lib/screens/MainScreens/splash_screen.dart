import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bayoum_store_app/authgate.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FlutterNativeSplash extends StatefulWidget {
  const FlutterNativeSplash({super.key});

  @override
  State<FlutterNativeSplash> createState() => _FlutterNativeSplashState();
}

class _FlutterNativeSplashState extends State<FlutterNativeSplash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/location.json',
                height: 75,
                width: 75,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bayoum',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Store',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      letterSpacing: 2,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      nextScreen: const AuthGate(),
      backgroundColor: Colors.white,
      duration: 3000,
    );
  }
}
