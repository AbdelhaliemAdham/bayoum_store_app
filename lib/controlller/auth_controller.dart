import 'dart:io';

import 'package:bayoum_store_app/screens/auth/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(File? file) async {
    UploadTask uploadTask = _firebaseStorage
        .ref()
        .child('profileImages')
        .child(_auth.currentUser!.uid)
        .putFile(file!);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  Future<String> createUser(String email, String password, String? fullName,
      BuildContext context, File? file, String? phoneNumber) async {
    String? message;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String imageUrl = await uploadImageToStorage(file);
      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'email': email,
        'fullName': fullName,
        'password': password,
        'buyerId': userCredential.user!.uid,
        'photo': imageUrl,
        'phoneNumber': phoneNumber,
      });
      message = 'user registered succesfully';
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const FirstScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      message = e.toString();
    }
    return message;
  }

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    String? message;
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      message = 'logged in successfuly';
    } on FirebaseAuthException catch (e) {
      message = e.toString();
    }
    return message;
  }
}
