import 'package:bayoum_store_app/model/favourite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteProvider, Map<String, FavouriteModel>>(
  (ref) => FavoriteProvider(),
);

class FavoriteProvider extends StateNotifier<Map<String, FavouriteModel>> {
  FavoriteProvider() : super({});

  void addProductToFavorite(
    double productPrice,
    String productName,
    List productImage,
    int avialableQuantity,
    int productQuantity,
    String vendorId,
    String productId,
  ) {
    state[productId] = FavouriteModel(
      productName: productName,
      productPrice: productPrice,
      productImage: productImage,
      avialableQuantity: avialableQuantity,
      productQuantity: productQuantity,
      vendorId: vendorId,
      productId: productId,
    );
    state = {...state};
  }

  void removeAllProducts() {
    state.clear();
    state = {...state};
  }

  void removeSingleProduct(
    String productId,
  ) {
    state.removeWhere((key, value) => key == productId);
    state = {...state};
  }

  Map<String, FavouriteModel> get getProducts => state;
}
