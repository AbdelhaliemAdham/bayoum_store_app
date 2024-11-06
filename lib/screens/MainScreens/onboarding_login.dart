import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/screens/MainScreens/onboarding_register.dart';
import 'package:bayoum_store_app/screens/auth/login.dart';
import 'package:bayoum_store_app/screens/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreenLogin extends StatefulWidget {
  const OnBoardingScreenLogin({super.key});

  @override
  State<OnBoardingScreenLogin> createState() => _OnBoardingScreenLoginState();
}

class _OnBoardingScreenLoginState extends State<OnBoardingScreenLogin> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.redAccent.shade200,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 40,
              child: Image.asset(
                Assets.loginJson,
                width: screenWidth * 0.8,
                height: screenHeight * 0.07,
              ),
            ),
            CustomButton(
              onTap: () => Get.to(
                () => CustomerLoginScreen(
                  type: 'Customer',
                ),
              ),
              top: screenHeight * 0.7,
              left: screenWidth * 0.07,
              text: 'Login as Customer',
            ),
            CustomButton(
              onTap: () => Get.to(
                () => CustomerLoginScreen(
                  type: 'Seller',
                ),
              ),
              top: screenHeight * 0.85,
              left: screenWidth * 0.85,
              text: 'Login as seller',
            ),
            Positioned(
                top: screenHeight * 0.88,
                left: screenWidth * 0.6,
                child: Row(
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => (() => const OnBoardingScreenRegister()),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
