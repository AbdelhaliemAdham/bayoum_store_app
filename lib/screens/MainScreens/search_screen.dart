import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/screens/MainScreens/product_card.dart';
import 'package:bayoum_store_app/screens/auth/widgets/empty_cart_widget.dart';
import 'package:bayoum_store_app/screens/inner-screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchEngine extends StatefulWidget {
  const SearchEngine({super.key, required this.product});
  final String product;
  @override
  State<SearchEngine> createState() => _SearchEngineState();
}

class _SearchEngineState extends State<SearchEngine> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: widget.product == ''
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        crossAxisAlignment: widget.product == ''
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('products')
                    .where(
                      'productName',
                      isEqualTo: widget.product,
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.data!.docs.isNotEmpty) {
                    isEmpty = false;

                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: Skeletonizer(
                        enabled:
                            snapshot.connectionState == ConnectionState.waiting,
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 6,
                              mainAxisExtent: 300,
                              crossAxisSpacing: 6,
                              childAspectRatio: 1 / 1,
                            ),
                            itemBuilder: (context, index) {
                              final product = snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    () => ProductDetailsScreen(
                                      productDetails: product,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ProductCard(
                                    productImages: product['imagesUrlList'][0],
                                    productName: product['productName'],
                                    productPrice:
                                        product['productPrice'].toString(),
                                    productDescription:
                                        product['productDescription'],
                                    productId: product['productId'],
                                    productImagesList: product['imagesUrlList'],
                                    avialableQuantity:
                                        product['productQuantity'],
                                    vendorId: product['vendorId'],
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                  return widget.product == ''
                      ? const EmptyCartWidget(
                          text: '',
                          image: Assets.detective,
                        )
                      : const SizedBox.shrink();
                }),
          ),
        ],
      ),
    );
  }
}
