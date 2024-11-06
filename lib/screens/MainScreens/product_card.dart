import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controlller/providers/favoriteprovider.dart';

class ProductCard extends ConsumerStatefulWidget {
  const ProductCard({
    super.key,
    required this.productImages,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productId,
    required this.productImagesList,
    required this.avialableQuantity,
    required this.vendorId,
  });

  static Color get courseCardColor => const Color(0xFFEDF1F1);

  final String productImages;
  final String productName;
  final String productPrice;
  final String productDescription;
  final String? productId;
  final List<dynamic>? productImagesList;
  final int? avialableQuantity;
  final String? vendorId;
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final favoritePro = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    bool isFavourite = favoritePro.getProducts.containsKey(widget.productId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: 140,
            width: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.productImages,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 3,
            right: 3,
            child: IconButton(
              onPressed: isFavourite
                  ? null
                  : () {
                      if (widget.productId != null) {
                        favoritePro.addProductToFavorite(
                          double.parse(widget.productPrice),
                          widget.productName,
                          widget.productImagesList ?? [],
                          widget.avialableQuantity ?? 0,
                          1,
                          widget.vendorId ?? '',
                          widget.productId ?? '',
                        );
                      }
                    },
              icon: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100, shape: BoxShape.circle),
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          child: Text(
            widget.productName,
            style: const TextStyle(
                fontFamily: 'Dm Sans', fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4),
          child: Text(
            '\$ ${widget.productPrice}',
            style:
                const TextStyle(fontFamily: 'Dm Sans', color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
