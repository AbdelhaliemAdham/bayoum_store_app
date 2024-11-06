import 'package:bayoum_store_app/authgate.dart';
import 'package:bayoum_store_app/helper/binding.dart';
import 'package:bayoum_store_app/screens/MainScreens/accountscreen.dart';
import 'package:bayoum_store_app/screens/MainScreens/cartscreen.dart';
import 'package:bayoum_store_app/screens/MainScreens/homescreen.dart';
import 'package:bayoum_store_app/screens/MainScreens/onboarding_login.dart';
import 'package:bayoum_store_app/screens/MainScreens/onboarding_register.dart';
import 'package:bayoum_store_app/screens/MainScreens/profile_screen.dart';
import 'package:bayoum_store_app/screens/MainScreens/searchscreen.dart';
import 'package:bayoum_store_app/screens/MainScreens/categoryscreen.dart';
import 'package:bayoum_store_app/screens/auth/RegisterPage.dart';
import 'package:bayoum_store_app/screens/auth/SignOutScreen.dart';
import 'package:bayoum_store_app/screens/auth/login.dart';
import 'package:bayoum_store_app/screens/MainScreens/mainscreen.dart';
import 'package:bayoum_store_app/screens/auth/widgets/categories_list_widget.dart';
import 'package:bayoum_store_app/screens/inner-screens/chat_screen.dart';
import 'package:bayoum_store_app/screens/inner-screens/checkout_Screen.dart';
import 'package:bayoum_store_app/screens/inner-screens/customer_order_screen.dart';
import 'package:bayoum_store_app/screens/inner-screens/edit_profile_screen.dart';
import 'package:bayoum_store_app/screens/inner-screens/paymentScreen.dart';
import 'package:bayoum_store_app/screens/inner-screens/product_details_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static String cartScreen = '/cartScreen';
  static String checkOutScreen = '/checkOutScreen';
  static String searchScreen = '/searchScreen';
  static String accountScreen = '/accountScreen';
  static String mainScreen = '/mainScreen';
  static String authGate = '/';
  static String firstScreen = '/firstScreen';
  static String secondScreen = '/secondScreen';
  static String home = '/homeScreen';
  static String signOutScreen = '/signOutScreen';
  static String customerRegisterScreen = '/customerRegisterScreen';
  static String customerLoginScreen = '/customerLoginScreen';
  static String categoryScreen = '/categoryScreen';
  static String productDetailsScreen = '/productDetailsScreen';
  static String paymentScreen = '/paymentScreen';
  static String customerOrderScreen = '/customerOrderScreen';
  static String chatScreen = '/chatScreen';
  static String editProfileScreen = '/editProfileScreen';
  static String profileScreen = '/profileScreen';
  static final routes = [
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: editProfileScreen,
      page: () => const EditProfileScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: chatScreen,
      page: () => const ChatScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: customerOrderScreen,
      page: () => CustomerOrderScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: checkOutScreen,
      page: () => const CheckOutScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: paymentScreen,
      page: () => const PaymentScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: categoryScreen,
      page: () => const CategoryScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: authGate,
      page: () => const AuthGate(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: cartScreen,
      page: () => const CartScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: accountScreen,
      page: () => const AccountScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: mainScreen,
      page: () => const MainScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: searchScreen,
      page: () => const SearchScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: customerRegisterScreen,
      page: () => const CustomerRegisterScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: firstScreen,
      page: () => const OnBoardingScreenRegister(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: secondScreen,
      page: () => const OnBoardingScreenLogin(),
      binding: GlobalBindings(),
    ),
    GetPage(
        name: signOutScreen,
        page: () => const SignOutScreen(),
        binding: GlobalBindings()),
    GetPage(
      name: customerLoginScreen,
      page: () => const CustomerLoginScreen(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: productDetailsScreen,
      page: () => const ProductDetailsScreen(),
      binding: GlobalBindings(),
    ),
  ];
}
