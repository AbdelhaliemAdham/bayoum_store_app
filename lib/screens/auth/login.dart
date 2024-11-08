// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bayoum_store_app/helper/AppPages.dart';
import 'package:bayoum_store_app/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bayoum_store_app/helper/snackbar.dart';
import 'package:bayoum_store_app/screens/MainScreens/mainscreen.dart';
import 'package:bayoum_store_app/screens/auth/widgets/textformfield.dart';

import '../../controlller/auth_controller.dart';

class CustomerLoginScreen extends StatefulWidget {
  final String? type;

  const CustomerLoginScreen({super.key, this.type});

  @override
  _CustomerLoginScreenState createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthController _authController = Get.find();

  String? password;
  String? email;

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool singInWithGoogle = false;

  login(String email, String password) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String message =
          await _authController.loginWithEmailAndPassword(email, password);
      setState(() {
        isLoading = false;
      });
      if (message == 'logged in successfuly') {
        Get.to(
          const MainScreen(),
        );
        HelperFun.showSnackBarWidegt(
          message,
          'LoggingIn',
        );
      } else {
        HelperFun.showSnackBarWidegt(
          message,
          'Error',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          canPop: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Hello Again!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Welcome back  you”ve been missed!',
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
              const SizedBox(height: 50),
              CustomFormField(
                icon: Icons.email,
                onChanged: (value) {
                  if (value!.isNotEmpty) {
                    setState(() => email = value);
                  }
                },
                inputType: TextInputType.emailAddress,
                labelText: 'Email',
                validator: (String? value) {
                  if (value != null &&
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return null;
                  }
                  {
                    return "Invalid email ";
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomFormField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                labelText: 'Password',
                icon: Icons.person,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.isNotEmpty &&
                      value.length >= 12 &&
                      value.length <= 6) {
                    return 'please enter password from from 6 to 12 numbers ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  style: ButtonStyle(
                    shadowColor: const MaterialStatePropertyAll(Colors.grey),
                    elevation: MaterialStateProperty.all<double?>(5),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle?>(
                      const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      login(email!, password!);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const Divider(
                color: Colors.grey,
                thickness: 0.3,
                indent: 50,
                endIndent: 50,
              ),
              const SizedBox(height: 30),
              const Text(
                'Or continue with',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      var userCredential =
                          await _authController.singInWithGoogle();
                      if (userCredential != null) {
                        Get.toNamed(AppPages.authGate);
                      }
                      return;
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(Assets.google),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      await _authController.signInWithTwitter();
                      Get.toNamed(AppPages.authGate);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(Assets.twitter),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppPages.signOutScreen);
                },
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
