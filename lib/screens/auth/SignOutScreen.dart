import 'dart:io';

import 'package:bayoum_store_app/controlller/auth_controller.dart';
import 'package:bayoum_store_app/screens/auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:bayoum_store_app/screens/auth/widgets/textformfield.dart';

import '../../helper/snackbar.dart';

class SignOutScreen extends StatefulWidget {
  const SignOutScreen({super.key});

  @override
  _SignOutScreenState createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
  final AuthController _authController = Get.find();
  AnimationController? animationController;
  Animation<Color>? animation;
  void _submit() async {
    fullName = '$firstName $lastName';
    setState(() {
      showProgressBar = true;
    });
    String message = await _authController.createUser(
      email,
      password,
      fullName,
      context,
      image,
      phone,
    );
    setState(() {
      showProgressBar = false;
    });
    if (message == 'user registered succesfully') {
      HelperFun.showSnackBarWidegt(
        message,
        'Register',
      );
      Get.to(const FirstScreen());
    } else {
      HelperFun.showSnackBarWidegt(
        message,
        'Error',
      );
    }
  }

  String? fullName;
  late String email;
  late String firstName;
  late String lastName;
  late String password;
  late String phone;
  File? image;
  bool imageGetPicked = false;
  bool showProgressBar = false;

  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        imageGetPicked = true;
      }
    });
  }

  _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        imageGetPicked = true;
      }
    });
  }

  final String? arguments = Get.arguments;

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
              Text(
                'Sign Out as ${arguments ?? ''}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (imageGetPicked) {
                                        setState(() {
                                          image!.deleteSync();
                                          imageGetPicked = false;
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            title: const Text(
                                'Do you want to delete this image ?'),
                          );
                        }),
                    child: imageGetPicked
                        ? const Icon(
                            Icons.remove_circle,
                            size: (35),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Choose an option to take picture',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              actions: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _pickImageFromCamera();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.camera_enhance_outlined,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    'Camera',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _pickImageFromGallery();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    'Gallery',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: imageGetPicked == false
                          ? const Icon(
                              Icons.add_a_photo,
                              size: (120),
                            )
                          : Image.file(
                              image!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              CustomFormField(
                  labelText: "firstName",
                  onChanged: (value) {
                    if (value!.isNotEmpty) {
                      firstName = value;
                    }
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter you firstName';
                    }
                    return null;
                  }),
              const SizedBox(height: 20),
              CustomFormField(
                  labelText: "lastName",
                  onChanged: (value) {
                    if (value!.isNotEmpty) {
                      lastName = value;
                    }
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter you lastName';
                    }
                    return null;
                  }),
              const SizedBox(height: 20),
              CustomFormField(
                onChanged: (value) {
                  if (value!.isNotEmpty) {
                    email = value;
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
                labelText: 'Password',
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                onChanged: (value) {
                  if (value!.isNotEmpty) {
                    password = value;
                  }
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              CustomFormField(
                onChanged: (value) {
                  if (value!.isNotEmpty) {
                    setState(() => phone = value);
                  }
                },
                inputType: TextInputType.phone,
                labelText: 'Phone',
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter your phone number ";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              showProgressBar
                  ? Center(
                      child: CircularStepProgressIndicator(
                        totalSteps: 100,
                        currentStep: 74,
                        stepSize: 10,
                        selectedColor: Colors.deepOrangeAccent,
                        unselectedColor: Colors.grey[200],
                        padding: 0,
                        width: 150,
                        height: 150,
                        selectedStepSize: 15,
                        roundedCap: (_, __) => true,
                      ),
                    )
                  : Padding(
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
                            _submit();
                          } else {
                            HelperFun.showSnackBarWidegt(
                              'Please type all the data required to register',
                              'Error',
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sign Out',
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
