import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashData {
  static CollectionReference buyersCollection =
      FirebaseFirestore.instance.collection('buyers');
  static late SharedPreferences sharedPreferences;
  static Future<void> initializeSharedPrefrences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setSharedData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    }
    return false;
  }

  static Future<String?>? getSharedData({required String key}) async {
    return sharedPreferences.getString(key);
  }

  static updateBuyer() async {
    DocumentSnapshot<Object?> future = await buyersCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (future.data() != null) {
      Map<String, dynamic> data = future.data() as Map<String, dynamic>;
      if (data['fullName'] != null || data['buyerId'] != null) {
        CashData.setSharedData(key: 'fullName', value: data['fullName']);
        CashData.setSharedData(key: 'email', value: data['email']);
        CashData.setSharedData(key: 'photo', value: data['photo']);
        CashData.setSharedData(key: 'phoneNumber', value: data['phoneNumber']);
      }
    }
  }
}
