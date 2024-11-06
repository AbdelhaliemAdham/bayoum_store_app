import 'package:bayoum_store_app/screens/auth/RegisterPage.dart';
import 'package:bayoum_store_app/screens/auth/login.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  void openExternalApp(String text) async {
    String url =
        'const url = "https://wa.me/?text=$text";'; // استبدل هذا بالرابط الخاص بالتطبيق
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'لا يمكن فتح التطبيق';
    }
  }

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
                  () => const CustomerRegisterScreen(),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account ? ",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Please',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    TextSpan(
                        text: ' sign up',
                        style: TextStyle(
                            fontSize: 18, color: Colors.orangeAccent.shade400)),
                    const TextSpan(
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
          'Login',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          'please sign in to continue',
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
              const CustomerLoginScreen(
                type: 'Buyer',
              ),
              transition: Transition.fade,
              curve: Curves.easeIn,
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
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orangeAccent.shade400),
          ),
          child: const Text(
            'Login as Buyer',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ElevatedButton(
          onPressed: () async {
            if (LaunchApp.isAppInstalled()) {
              await LaunchApp.openApp(
                androidPackageName: 'com.bayoum vendor',
                openStore: true,
              );
            }
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
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orangeAccent.shade400),
          ),
          child: const Text(
            'Login as Vendor',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
