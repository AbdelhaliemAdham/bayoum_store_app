import 'package:bayoum_store_app/authgate.dart';
import 'package:bayoum_store_app/controlller/auth_controller.dart';
import 'package:bayoum_store_app/controlller/services/category_contoller.dart';
import 'package:bayoum_store_app/screens/auth/SignOutScreen.dart';
import 'package:bayoum_store_app/screens/auth/login.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(const SignOutScreen(), permanent: true);
    Get.put(const CustomerLoginScreen(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(const AuthGate(), permanent: true);
    Get.put(
      CategoryController(),
    );
  }
}
