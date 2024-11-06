// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bayoum_store_app/controlller/providers/cart_provider.dart';

// ignore: must_be_immutable
class CartWidget extends ConsumerStatefulWidget {
  final String imageUrl;
  final String? size;
  final String price;
  int quantity;
  String productId;
  String productName;

  CartWidget({
    super.key,
    required this.imageUrl,
    this.size,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.productName,
  });

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends ConsumerState<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.read(cartProvider.notifier);
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 1,
          ),
          const BoxShadow(
            color: Colors.white,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.network(
                  widget.imageUrl,
                  // height: 100,
                  // width: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  'Size : ${widget.size!.toUpperCase()}',
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
                Text(
                  '\$ ${widget.price.toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantity : ',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // decrement quantity logic here
                          provider.decreamentItems(widget.productId);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.quantity.toString(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // increment quantity logic here
                          provider.increamentItems(widget.productId);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
