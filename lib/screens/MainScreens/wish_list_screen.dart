import 'package:bayoum_store_app/controlller/providers/favoriteprovider.dart';
import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/model/favourite.dart';
import 'package:bayoum_store_app/screens/MainScreens/product_card.dart';
import 'package:bayoum_store_app/screens/auth/widgets/dissmisable_widget.dart';
import 'package:bayoum_store_app/screens/auth/widgets/empty_cart_widget.dart';
import 'package:bayoum_store_app/screens/auth/widgets/wish_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
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
        mainAxisAlignment: isFavouriteEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          isFavouriteEmpty == false
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 3,
                      mainAxisExtent: 300 // <-- this works!

                      ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: favProvider.length,
                  itemBuilder: (context, index) {
                    FavouriteModel favouriteModel =
                        favProvider.values.toList()[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onLongPress: () async {
                          await showDialog(
                              context: (context),
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Product'),
                                  content: const Text(
                                      'Are you sure you want to delete this product?'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            provider.removeSingleProduct(
                                                favouriteModel.productId);
                                            setState(() {});
                                            Get.back();
                                          },
                                          child: const Text('Delete'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        },
                        child: WishListCard(
                          productImages: favouriteModel.productImage[0],
                          productName: favouriteModel.productName,
                          productPrice:
                              favouriteModel.productPrice.toStringAsFixed(1),
                          productDescription: '',
                          productId: favouriteModel.productId,
                          productImagesList: favouriteModel.productImage,
                          avialableQuantity: favouriteModel.avialableQuantity,
                          vendorId: favouriteModel.vendorId,
                        ),
                      ),
                    );
                  })
              : const EmptyCartWidget(
                  text: 'Your WishList is empty !',
                  image: Assets.wishList,
                ),
        ],
      ),
    );
  }
}
