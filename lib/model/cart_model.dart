class CartModel {
  final String productName;
  final String productPrice;
  final String productImage;
  int avialableQuantity;
  int productQuantity;
  final String vendorId;
  final String productId;
  final String productSize;

  CartModel({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.vendorId,
    required this.productId,
    required this.productSize,
    required this.avialableQuantity,
    required this.productQuantity,
  });
}
