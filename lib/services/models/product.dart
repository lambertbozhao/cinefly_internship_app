/// A class to represent a product.
class Product {
  /// The unique identifier of a product.
  final int id;
  /// The name of a product.
  final String name;
  /// A brief description of a product.
  final String description;
  /// The price of a product.
  final double price;
  /// The URL of a product's image.
  final String imageUrl;

  /// Creates a product with the provided properties.
  Product(this.id, this.name, this.description, this.price, this.imageUrl);

  /// Creates a product from a [json] map.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['price'] as double,
      json['imageUrl'] as String,
    );
  }
}
