import 'package:bayoum_store_app/screens/auth/SignOutScreen.dart';
import 'package:bayoum_store_app/screens/auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key, String? routeName});

  final String routeName = 'SignIn_Screen';

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 3,
          child: _buildLogo(),
        ),
        Expanded(
          flex: 4,
          child: _body(),
        ),
        const Expanded(
          flex: 1,
          child: _footer(),
        )
      ]),
    );
  }
}

class _footer extends StatelessWidget {
  const _footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () async {
                await Get.to(
                  () => const FirstScreen(),
                );
              },
              child: RichText(
                text: const TextSpan(
                  text: "Do you have an account ? ",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Sign In',
                        style: TextStyle(fontSize: 18, color: Colors.red)),
                    TextSpan(
                        text: ' with us !',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildLogo() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    alignment: Alignment.topLeft,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Register',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          'please sign out this form to continue',
          style: TextStyle(
            fontSize: 19,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

Widget _body() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            Get.to(
              () => const SignOutScreen(),
              transition: Transition.fade,
              curve: Curves.easeIn,
              arguments: 'Buyer',
            );
          },
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll<Size>(
              Size(double.maxFinite, 70),
            ),
            maximumSize: const MaterialStatePropertyAll<Size>(
              Size(double.maxFinite, 70),
            ),
            alignment: Alignment.center,
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          child: const Text(
            'Register as Buyer',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ElevatedButton(
          onPressed: () {
            Get.to(
              () => const SignOutScreen(),
              transition: Transition.fade,
              curve: Curves.easeIn,
              arguments: 'Vender',
            );
          },
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll<Size>(
              Size(double.maxFinite, 70),
            ),
            maximumSize: const MaterialStatePropertyAll<Size>(
              Size(double.maxFinite, 70),
            ),
            alignment: Alignment.center,
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          child: const Text(
            'Register as Vendor',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
