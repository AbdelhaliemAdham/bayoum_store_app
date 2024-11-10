import 'package:bayoum_store_app/screens/MainScreens/product_card.dart';
import 'package:bayoum_store_app/screens/inner-screens/product_details.dart';
import 'package:bayoum_store_app/screens/inner-screens/product_details_screen.dart';
import 'package:bayoum_store_app/screens/productCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WomenProducts extends StatefulWidget {
  const WomenProducts({super.key});

  @override
  State<WomenProducts> createState() => _WomenProductsState();
}

class _WomenProductsState extends State<WomenProducts> {
  final Stream<QuerySnapshot> _productsScreen = FirebaseFirestore.instance
      .collection('products')
      .where('productCategory', isEqualTo: 'women')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsScreen,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.data == null) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: SizedBox(
            height: 200,
            child: Skeletonizer(
              enabled: snapshot.connectionState == ConnectionState.waiting,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = snapshot.data!.docs[index];
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => ProductDetails(
                            productDetails: product,
                          ),
                        );
                      },
                      child: ProductCard(
                        productImages: product['imagesUrlList'][0],
                        productName: product['productName'],
                        productPrice: product['productPrice'].toString(),
                        productDescription: product['productDescription'],
                        productId: product['productId'],
                        productImagesList: product['imagesUrlList'],
                        avialableQuantity: product['productQuantity'],
                        vendorId: product['vendorId'],
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}
