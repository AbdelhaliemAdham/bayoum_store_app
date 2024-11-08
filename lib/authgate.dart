import 'package:bayoum_store_app/screens/auth/welcome_screen.dart';
import 'package:bayoum_store_app/screens/MainScreens/mainscreen.dart';
import 'package:bayoum_store_app/screens/inner-screens/internet_lost_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool connected = false;
  internetConnectionChecker() async {
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            connected = true;
          });
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            connected = false;
          });
          break;
      }
    });
  }

  @override
  initState() {
    super.initState();
    internetConnectionChecker();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return StreamBuilder<User?>(
        initialData: auth.currentUser,
        stream: auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (connected) {
            if (!snapshot.hasData) {
              return const FirstScreen();
            }

            return const MainScreen();
          }
          return const MainScreen();
        });
  }
}
