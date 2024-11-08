import 'package:bayoum_store_app/helper/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/AppPages.dart';
import '../auth/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  isLogin() {
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    if (uid.isEmpty) {
      return false;
    }
    return true;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> buyersCollection =
      FirebaseFirestore.instance
          .collection('buyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Dm Sans',
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: buyersCollection,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Some thing wrong happened'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width - 25,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 12,
                            spreadRadius: 6,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                          ),
                        ],
                        color: const Color(0xffEF4637),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: firstContainer(
                        name: data['fullName'],
                        email: data['email'],
                        photo: data['photo'],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    width: MediaQuery.of(context).size.width - 25,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SecondContainer(),
                  ),
                ),
                const textWidget(),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width - 25,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const lastContainer(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class lastContainer extends StatelessWidget {
  const lastContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff0601B4).withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Color(0xff0601B4),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help & Support',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DM Sans',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff0601B4).withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xff0601B4),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About App',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DM Sans',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class textWidget extends StatelessWidget {
  const textWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        child: const Text(
          'More',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'DM Sans',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SecondContainer extends StatefulWidget {
  SecondContainer({
    super.key,
  });

  @override
  State<SecondContainer> createState() => _SecondContainerState();
}

class _SecondContainerState extends State<SecondContainer> {
  bool darkMode = false;
  signOut() {
    FirebaseAuth.instance.signOut().whenComplete(
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return const FirstScreen();
            }),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Get.toNamed(AppPages.editProfileScreen);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff0601B4).withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Color(0xff0601B4),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Account',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Make changes to my account',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppPages.customerOrderScreen);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff0601B4).withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Image.asset(
                        Assets.orders,
                        width: 25,
                        height: 25,
                        color: const Color(0xff0601B4),
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Orders',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Manage your Orders',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppPages.cartScreen);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff0601B4).withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Image.asset(
                        Assets.shoppingCart,
                        width: 25,
                        height: 25,
                        color: const Color(0xff0601B4),
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cart',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Manage your cart items',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff0601B4).withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Image.asset(
                      Assets.dark,
                      width: 25,
                      height: 25,
                      color: const Color(0xff0601B4),
                    ),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dark',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DM Sans',
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Manage your device security',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DM Sans',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSwitch(
                  activeColor: Colors.red,
                  trackColor: Colors.grey,
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });
                  }),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            signOut();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff0601B4).withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Image.asset(
                        Assets.logout,
                        width: 25,
                        height: 25,
                        color: const Color(0xff0601B4),
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Sign out with another account',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class firstContainer extends StatelessWidget {
  const firstContainer({
    super.key,
    required this.name,
    required this.email,
    required this.photo,
  });

  final String? name;
  final String? email;
  final String? photo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: photo == null
                      ? const AssetImage(Assets.user)
                      : Image.network(photo!).image,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    name ?? 'Abdelhaliem Adham',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  email ?? 'abdo09adham@gmail.com',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'DM Sans',
                    color: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Icon(Icons.edit, color: Colors.white, size: 25),
      ],
    );
  }
}
