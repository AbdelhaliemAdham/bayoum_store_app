import 'package:bayoum_store_app/controlller/services/local_notification.dart';
import 'package:bayoum_store_app/firebase_options.dart';
import 'package:bayoum_store_app/helper/AppPages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'helper/binding.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  void initState() {
    super.initState();
    initialization();
    initializeNotification();
  }

  void initializeNotification() async {
    await LocalNotification.initializeNotification();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 15));
    FlutterNativeSplash.remove();
  }

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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.red),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
    );
  }
}
