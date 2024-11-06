import 'dart:math';

import 'package:bayoum_store_app/model/cart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider =
    StateNotifierProvider<CartProvider, Map<String, CartModel>>(
        (ref) => CartProvider());

class CartProvider extends StateNotifier<Map<String, CartModel>> {
  CartProvider() : super({});
  void addProductToCart(
    String productName,
    String productPrice,
    String productImage,
    int avialableQuantity,
    int productQuantity,
    String vendorId,
    String productId,
    String productSize,
  ) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: CartModel(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          productImage: state[productId]!.productImage,
          vendorId: state[productId]!.vendorId,
          productId: state[productId]!.productId,
          productSize: state[productId]!.productSize,
          avialableQuantity: state[productId]!.avialableQuantity - 1,
          productQuantity: state[productId]!.productQuantity++,
        )
      };
    } else {
      state = {
        ...state,
        productId: CartModel(
          productName: productName,
          productPrice: productPrice,
          productImage: productImage,
          vendorId: vendorId,
          productId: productId,
          productSize: productSize,
          avialableQuantity: avialableQuantity,
          productQuantity: productQuantity,
        ),
      };
    }
  }

  void increamentItems(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.productQuantity++;
    }
    state = {...state};
  }

  void decreamentItems(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.productQuantity--;
    }
    state = {...state};
  }

  double calculateTotalAmount() {
    double total = 0;
    state.forEach((productId, cart) {
      total += cart.productQuantity * double.parse(cart.productPrice);
    });
    // state = {
    //   ...state,
    // };
    return total;
  }

  Map<String, CartModel> get getAllCartItems => state;

  void removeAllCartItems() {
    state.clear();
    state = {...state};
  }

  void deleteCartItem(String productId) {
    if (state.containsKey(productId)) {
      try {
        state.removeWhere((key, value) {
          return key == productId;
        });
      } catch (e) {
        // handle error
        debugPrint('Error deleting item from cart: $e');
      }
    } else {
      debugPrint('Item not found in cart');
    }
  }

  double getRandomNumber() {
    Random random = Random();
    return random.nextDouble() * 50 +
        1; // Generates a number from 0 to 49, then adds 1
  }

  String getFormatedAmount(double totalAmount) {
    double randomDeduction = getRandomNumber();
    double finalAmount = (totalAmount - randomDeduction);
    String formattedAmount = finalAmount.toInt().toString();
    String displayAmount = "\$ $formattedAmount";

    return displayAmount;
  }
}
