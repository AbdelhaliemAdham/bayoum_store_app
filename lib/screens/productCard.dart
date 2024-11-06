import 'package:bayoum_store_app/controlller/providers/favoriteprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardWidget extends ConsumerStatefulWidget {
  const CardWidget({
    super.key,
    required this.productImages,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    this.productId,
    this.productImagesList,
    this.avialableQuantity,
    this.vendorId,
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
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends ConsumerState<CardWidget> {
  @override
  Widget build(BuildContext context) {
    final favoritePro = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    bool isFavourite = favoritePro.getProducts.containsKey(widget.productId);
    return Container(
      decoration: BoxDecoration(
        color: CardWidget.courseCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8.0),
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5.0),
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    widget.productImages,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.productName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    widget.productDescription,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                        child: Text(
                          "\$ ${widget.productPrice}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      IconButton(
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
                        icon: Icon(
                          isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
