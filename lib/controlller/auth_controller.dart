import 'dart:io';

import 'package:bayoum_store_app/screens/auth/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
        apiKey: 'BLCkZkFXtvdAhhBJqu95DpNrx',
        apiSecretKey: 'o0cVzP0MlyysZAJzlJuvARzuVkMkNEL6Lhgua3naMwAcETgjE9',
        redirectURI: 'flutter-twitter-login://');

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    var userCredential =
        await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    await _firestore.collection('buyers').doc(_auth.currentUser!.uid).set({
      'fullName': _auth.currentUser!.displayName,
      'email': _auth.currentUser!.email,
      'phoneNumber': _auth.currentUser!.phoneNumber,
      'photo': _auth.currentUser!.photoURL,
    });
    return userCredential;
  }

  Future<UserCredential?> singInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await _firestore.collection('buyers').doc(_auth.currentUser!.uid).set({
        'fullName': _auth.currentUser!.displayName,
        'email': _auth.currentUser!.email,
        'phoneNumber': _auth.currentUser!.phoneNumber,
        'photo': _auth.currentUser!.photoURL,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      Get.showSnackbar(
        GetSnackBar(
          title: 'Google Sign In',
          message: e.toString(),
          duration: const Duration(seconds: 4),
          dismissDirection: DismissDirection.horizontal,
          isDismissible: true,
        ),
      );
    }
    Get.showSnackbar(
      const GetSnackBar(
        title: 'Google Sign In',
        message: 'error while sign in with google sign in method',
        duration: Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        isDismissible: true,
      ),
    );
    return null;
  }

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
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      message = 'logged in successfuly';
    } on FirebaseAuthException catch (e) {
      message = e.toString();
    }
    return message;
  }
}
