import 'product.dart';

/// A class to represent an item in a shopping cart.
class CartItem {
  /// The associated product.
  final Product product;
  /// The quantity of the product in the cart.
  int quantity;

  /// Creates a cart item with the provided product and quantity.
  CartItem({required this.product, this.quantity = 1});
}
