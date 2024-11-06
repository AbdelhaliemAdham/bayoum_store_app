import 'package:bayoum_store_app/controlller/providers/favoriteprovider.dart';
import 'package:bayoum_store_app/helper/fontthemes.dart';
import 'package:bayoum_store_app/model/favourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({super.key});

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favProvider = ref.watch(favoriteProvider);
    final provider = ref.read(favoriteProvider.notifier);
    bool isFavouriteEmpty = favProvider.values.isEmpty ? true : false;
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
        title: const Text('My WishList'),
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
                  provider.removeAllProducts();
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: isFavouriteEmpty == false
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: favProvider.length,
                        itemBuilder: (context, index) {
                          FavouriteModel favouriteModel =
                              favProvider.values.toList()[index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              child: SizedBox(
                                height: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 100,
                                        child: Image.network(
                                          favouriteModel.productImage[0]
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favouriteModel.productName,
                                            style: CustomFontStyle.medium,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '\$ ${favouriteModel.productPrice.toStringAsFixed(2)}',
                                            style:
                                                CustomFontStyle.small.copyWith(
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              provider.removeSingleProduct(
                                                  favouriteModel.productId);
                                            },
                                            icon: const Icon(
                                              Icons.cancel,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Center(
                    child: Text(
                      'Your wishlist is empty!',
                      style: CustomFontStyle.large.copyWith(letterSpacing: 3),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
