import 'package:bayoum_store_app/controlller/providers/cart_provider.dart';
import 'package:bayoum_store_app/helper/AppPages.dart';
import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/helper/math.dart';
import 'package:bayoum_store_app/model/cart_model.dart';
import 'package:bayoum_store_app/screens/auth/widgets/cart_widgets.dart';
import 'package:bayoum_store_app/screens/auth/widgets/check_out_button.dart';
import 'package:bayoum_store_app/screens/auth/widgets/dissmisable_widget.dart';
import 'package:bayoum_store_app/screens/auth/widgets/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    MyMath myMath = Get.put(MyMath());
    final cartData = ref.watch(cartProvider);
    final provider = ref.read(cartProvider.notifier);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    bool isCartEmpty = cartData.values.isEmpty ? true : false;
    int chargeFee = 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
            )),
        title: const Text('My Cart'),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: IconButton(
                onPressed: () {
                  provider.removeAllCartItems();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                  size: 20,
                )),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: isCartEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: isCartEmpty == false
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: cartData.length,
                        itemBuilder: (context, index) {
                          CartModel cart = cartData.values.toList()[index];
                          return Column(
                            children: [
                              SliderAction(
                                onDismissed: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .deleteCartItem(cart.productId);
                                  setState(() {});
                                },
                                child: CartWidget(
                                  imageUrl: cart.productImage,
                                  size: cart.productSize,
                                  price: cart.productPrice,
                                  quantity: cart.productQuantity,
                                  productId: cart.productId,
                                  productName: cart.productName,
                                ),
                              ),
                            ],
                          );
                        }),
                  )
                : const EmptyCartWidget(
                    text: 'Cart is empty,please add items to the cart !',
                    image: Assets.emptyCart,
                  ),
          ),
          InkWell(
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return Container(
                      height: 250.0,
                      color: Colors
                          .transparent, //could change this to Color(0xFF737373),
                      //so you don't have to change MaterialApp canvasColor
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Sub-Total"),
                                    Text(
                                      "\$ ${totalAmount.toInt().toString()}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("charge-Fee"),
                                    Text(
                                      "\$ ${chargeFee.toString()}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Discount"),
                                    Text(
                                      '-\$ ${myMath.randomNumber}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(color: Colors.grey),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Total Cost"),
                                    Text(
                                      myMath.getFormatedAmount(totalAmount),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppPages.paymentScreen);
                                },
                                child: const ProceedButton(),
                              ),
                            ],
                          )),
                    );
                  });
            },
            child:
                isCartEmpty ? const SizedBox.shrink() : const ProceedButton(),
          ),
        ],
      ),
    );
  }
}
