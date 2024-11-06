import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/screens/MainScreens/cartscreen.dart';
import 'package:bayoum_store_app/screens/MainScreens/homescreen.dart';
import 'package:bayoum_store_app/screens/MainScreens/categoryscreen.dart';
import 'package:bayoum_store_app/screens/MainScreens/profile_screen.dart';
import 'package:bayoum_store_app/screens/MainScreens/wish_list_screen.dart';
import 'package:bayoum_store_app/screens/auth/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  void logOut() async {
    await auth.signOut();
    Get.to(
      const FirstScreen(),
    );
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const WishListScreen(),
    const ProfileScreen(),
  ];
  int screenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[screenIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 1,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: CurvedNavigationBar(
            height: 50,
            backgroundColor: Colors.white,
            color: Colors.redAccent,
            buttonBackgroundColor: Colors.redAccent,
            index: screenIndex,
            onTap: (index) {
              setState(() {
                screenIndex = index;
              });
            },
            items: [
              Image.asset(Assets.home, scale: 20, color: Colors.white),
              Image.asset(Assets.category, scale: 20, color: Colors.white),
              Image.asset(Assets.shoppingCart, scale: 9, color: Colors.white),
              Image.asset(Assets.heart, scale: 18, color: Colors.white),
              Image.asset(Assets.profile, scale: 20, color: Colors.white),
            ]),
      ),
    );
  }
}
