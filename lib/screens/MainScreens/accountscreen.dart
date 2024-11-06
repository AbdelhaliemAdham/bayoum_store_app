import 'package:bayoum_store_app/helper/AppPages.dart';
import 'package:bayoum_store_app/helper/fontthemes.dart';
import 'package:bayoum_store_app/helper/shared_prefrences.dart';
import 'package:bayoum_store_app/screens/auth/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLoggedIn = false;
  late String _email;
  late String _name;
  late String photo;
  late String phoneNumber;
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    getBuyerDataFromSharedPref();
  }

  isLogin() {
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    if (uid.isEmpty) {
      return false;
    }
    return true;
  }

  getBuyerDataFromSharedPref() async {
    _email = await CashData.getSharedData(key: 'email') as String;
    _name = await CashData.getSharedData(key: 'fullName') as String;
    photo = await CashData.getSharedData(key: 'photo') as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
                fontSize: 22, letterSpacing: 4, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.dark_mode,
                size: 27,
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
        body: isLogin()
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    onBackgroundImageError: (object, trace) {},
                    radius: 60,
                    backgroundImage: NetworkImage(photo),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          _name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _email,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppPages.editProfileScreen);
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings, size: 35),
                    title: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.dark_mode, size: 35),
                    title: Text(
                      'DarkMode',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.phone, size: 35),
                    title: Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(AppPages.cartScreen),
                    child: const ListTile(
                      leading: Icon(Icons.card_travel, size: 35),
                      title: Text(
                        'Cart',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(AppPages.customerOrderScreen),
                    child: const ListTile(
                      leading: Icon(Icons.backpack, size: 35),
                      title: Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      FirebaseAuth.instance.signOut().whenComplete(
                            () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const FirstScreen();
                              }),
                            ),
                          );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.logout, size: 35),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.pink.shade900,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Please , Login to your Account to view your profile',
                      style: CustomFontStyle.small,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const FirstScreen();
                        }),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 150,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text(
                        'LOGIN ACCOUNT',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 4,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                    ),
                  ),
                ],
              ));
  }
}
