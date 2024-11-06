class Product {
  num id;
  String title;
  num price;
  String category;
  String image;

  Product(this.id, this.title, this.price, this.category, this.image);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json['id'], json['title'], json['price'], json['category'],
        json['image']);
  }

  Map<String, Object?> toMap(Product product) {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'image': image,
    };
  }
}
