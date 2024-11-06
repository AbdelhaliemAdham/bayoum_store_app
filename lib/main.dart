import 'package:bayoum_store_app/controlller/services/services.dart';
import 'package:bayoum_store_app/firebase_options.dart';
import 'package:bayoum_store_app/helper/AppPages.dart';
import 'package:bayoum_store_app/helper/math.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MyMath());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Stripe.publishableKey = publishableKey;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GlobalBindings(),
      initialRoute: AppPages.authGate,
      title: 'Bayoum-Store',
      theme: ThemeData(
        fontFamily: 'Dosis',
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.orangeAccent),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
    );
  }
}
