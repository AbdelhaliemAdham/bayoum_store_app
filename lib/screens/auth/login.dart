// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
      body: isLoading
          ? Center(
              child: CircularStepProgressIndicator(
                totalSteps: 100,
                currentStep: 74,
                stepSize: 10,
                selectedColor: Colors.deepOrangeAccent,
                unselectedColor: Colors.grey[200],
                padding: 0,
                width: 110,
                height: 110,
                selectedStepSize: 15,
                roundedCap: (_, __) => true,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                canPop: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign In as ${widget.type ?? 'Buyer'}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                        letterSpacing: 2,
                      ),
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
                          shadowColor:
                              const MaterialStatePropertyAll(Colors.grey),
                          elevation: MaterialStateProperty.all<double?>(5),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 18),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side: BorderSide.none,
                          )),
                          textStyle: MaterialStateProperty.all<TextStyle?>(
                            const TextStyle(color: Colors.white),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orangeAccent),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login(email!, password!);
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
