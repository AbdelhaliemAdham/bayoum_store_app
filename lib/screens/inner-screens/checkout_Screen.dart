import 'package:bayoum_store_app/controlller/providers/cart_provider.dart';
import 'package:bayoum_store_app/helper/fontthemes.dart';
import 'package:bayoum_store_app/helper/snackbar.dart';
import 'package:bayoum_store_app/model/cart_model.dart';
import 'package:bayoum_store_app/screens/MainScreens/mainscreen.dart';
import 'package:bayoum_store_app/screens/auth/widgets/checkOutWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CheckOutScreen extends ConsumerStatefulWidget {
  const CheckOutScreen({super.key});

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends ConsumerState<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final cartData = ref.watch(cartProvider);
    final provider = ref.read(cartProvider.notifier);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    bool isCartEmpty = cartData.values.isEmpty ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckOut'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: cartData.length,
            itemBuilder: (context, index) {
              CartModel cart = cartData.values.toList()[index];
              return Column(
                children: [
                  CheckOutWidget(
                    imageUrl: cart.productImage,
                    size: cart.productSize,
                    price: cart.productPrice,
                    quantity: cart.productQuantity,
                    productId: cart.productId,
                    productName: cart.productName,
                  ),
                ],
              );
            }),
      ),
      bottomSheet: InkWell(
        onTap: () async {
          if (!isCartEmpty) {
            Map<String, CartModel> cartItems = provider.getAllCartItems;
            FirebaseAuth auth = FirebaseAuth.instance;
            String userId = auth.currentUser!.uid;
            DocumentSnapshot<Map<String, dynamic>> userDoc =
                await firestore.collection('buyers').doc(userId).get();
            final orderId = const Uuid().v4();
            cartItems.forEach((key, item) async {
              await firestore.collection('orders').doc(orderId).set({
                'orderId': orderId,
                'productId': item.productId,
                'productName': item.productName,
                'quantity': item.productQuantity,
                'price': item.productQuantity * double.parse(item.productPrice),
                'availableQuantity': item.avialableQuantity,
                'vendorId': item.vendorId,
                'productSize': item.productSize,
                'productImage': item.productImage,
                'buyerId': userId,
                'email': (userDoc.data() as Map<String, dynamic>)['email'],
                'fullName':
                    (userDoc.data() as Map<String, dynamic>)['fullName'],
                'photo': (userDoc.data() as Map<String, dynamic>)['photo'],
                'accepted': false,
                'orderDate': DateTime.now(),
              });
            });
            cartItems.clear();
            HelperFun.showSnackBarWidegt(
                'order has sent to the vendor successfully ', 'Succes');
            await Get.to(
              () => const MainScreen(),
              curve: Curves.bounceOut,
              duration: const Duration(seconds: 1),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50,
          width: MediaQuery.of(context).size.width - 15,
          child: Center(
            child: Text(
              'Place Order  ${provider.getFormatedAmount(totalAmount)}',
              style: CustomFontStyle.large.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
