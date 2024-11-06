import 'dart:io';

import 'package:bayoum_store_app/helper/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controlller/auth_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool loading = false;

  File? image;
  bool imageGetPicked = false;
  String? countryPicked;
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  final AuthController _authController = Get.find();

  save() async {
    if (formKey.currentState!.validate() && countryPicked != null) {
      setState(() {
        loading = true;
      });
      String photo = await _authController.uploadImageToStorage(image);
      await _firestore
          .collection('buyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'photo': photo,
        'fullName': '$firstName $lastName',
        'phoneNumber': '$phoneNumber',
        'country': countryPicked,
      });
    }

    setState(() {
      loading = false;
    });
  }

  pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        imageGetPicked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: imageGetPicked
                        ? FileImage(image!) as ImageProvider
                        : const AssetImage(Assets.person),
                  ),
                  Positioned(
                    top: 100,
                    left: 115,
                    child: InkWell(
                      onTap: () async {
                        await pickImageFromGallery();
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        firstName = value;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        lastName = value;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your lastName';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        labelText: 'Last name',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone Number';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: Icon(Icons.phone_android_sharp),
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              onSelect: (Country country) {
                                setState(() {
                                  countryPicked = country.displayName;
                                });
                                print('Select country: ${country.displayName}');
                              },
                            );
                          },
                          child: const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                            opticalSize: 40,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        labelText: countryPicked ?? 'Select Country',
                        labelStyle: TextStyle(
                          fontWeight: countryPicked == null
                              ? FontWeight.normal
                              : FontWeight.bold,
                          color: countryPicked == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.90,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 238, 4, 4),
                      ),
                      BoxShadow(
                        color: Color.fromARGB(255, 124, 2, 2),
                      ),
                    ]),
                child: InkWell(
                  onTap: () {
                    save();
                  },
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.red.shade700,
                          ),
                        )
                      : const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
