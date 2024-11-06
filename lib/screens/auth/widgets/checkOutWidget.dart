import 'package:bayoum_store_app/controlller/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckOutWidget extends ConsumerStatefulWidget {
  final String imageUrl;
  final String? size;
  final String price;
  int quantity;
  String productId;
  String productName;

  CheckOutWidget({
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

class _CartWidgetState extends ConsumerState<CheckOutWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.read(cartProvider.notifier);
    return Container(
      height: 200,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 6,
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 6,
                        blurRadius: 12,
                      ),
                    ],
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
            const SizedBox(width: 15, height: 15),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName.toUpperCase(),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    '\$ ${widget.price.toString()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Quantity: ${widget.quantity}',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
