import 'package:bayoum_store_app/controlller/providers/favoriteprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishListCard extends ConsumerStatefulWidget {
  const WishListCard({
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
  // ignore: library_private_types_in_public_api
  _WishListCardState createState() => _WishListCardState();
}

class _WishListCardState extends ConsumerState<WishListCard> {
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
                width: 200,
                height: 200,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
                top: 10,
              ),
              child: Text(
                widget.productName,
                style: const TextStyle(
                    fontFamily: 'Dm Sans', fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '\$ ${widget.productPrice}',
                style: const TextStyle(
                    fontFamily: 'Dm Sans', color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
