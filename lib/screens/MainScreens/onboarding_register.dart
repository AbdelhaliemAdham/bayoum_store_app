import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/screens/MainScreens/onboarding_login.dart';
import 'package:bayoum_store_app/screens/auth/RegisterPage.dart';
import 'package:bayoum_store_app/screens/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnBoardingScreenRegister extends StatefulWidget {
  const OnBoardingScreenRegister({super.key});

  @override
  State<OnBoardingScreenRegister> createState() =>
      _OnBoardingScreenRegisterState();
}

class _OnBoardingScreenRegisterState extends State<OnBoardingScreenRegister> {
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
                () => const CustomerRegisterScreen(),
              ),
              top: screenHeight * 0.7,
              left: screenWidth * 0.07,
              text: 'Register as Customer',
            ),
            CustomButton(
              top: screenHeight * 0.85,
              left: screenWidth * 0.85,
              text: 'Register as seller',
            ),
            Positioned(
              top: screenHeight * 0.88,
              left: screenWidth * 0.6,
              child: Row(
                children: [
                  const Text(
                    'Already have an account ?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => Get.to(
                      () => const OnBoardingScreenLogin(),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
