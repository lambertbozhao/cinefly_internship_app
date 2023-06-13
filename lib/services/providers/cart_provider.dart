import 'package:flutter/foundation.dart';
import 'package:cinefly_internship_app/services/models/product.dart';
import 'package:cinefly_internship_app/services/models/cart.dart';

/// A provider class for managing shopping cart state.
class CartProvider with ChangeNotifier {
  /// A map to hold cart items, with product IDs as keys.
  Map<int, CartItem> _items = {};

  /// A getter for [_items].
  Map<int, CartItem> get items {
    return {..._items};
  }

  /// Adds a product to the cart.
  ///
  /// If the product is already in the cart, the quantity is incremented.
  /// If the product is not in the cart, it is added with a quantity of 1.
  void addItem(Product product, int quantity) {
    // Checking if the product is already in the cart
    if (_items.containsKey(product.id)) {
      // If the product is already in the cart, increment the quantity
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + quantity,
        ),
      );
    } else {
      // If the product is not in the cart, add it
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
          quantity: quantity
        ),
      );
    }
    // Notify all listeners about the update
    notifyListeners();
  }

  /// Removes a product from the cart by product ID.
  void removeItem(int productId) {
    // Remove the item with the given productId
    _items.remove(productId);
    // Notify all listeners about the update
    notifyListeners();
  }

  /// Clears all items from the cart.
  void clear() {
    // Reset the items map
    _items = {};
    // Notify all listeners about the update
    notifyListeners();
  }

  /// Calculates the total cost of the items in the cart.
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, item) {
      // Calculate the total amount
      total += item.product.price * item.quantity;
    });
    return total;
  }

  /// Method to increase the quantity of an item in the cart.
  void incrementItem(Product product) {
    if (_items.containsKey(product.id)) {
      // if item already exists in cart, increase the quantity
      _items.update(
        product.id,
            (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // if item does not exist in cart, add it
      _items.putIfAbsent(
        product.id,
            () => CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  /// Method to decrease the quantity of an item in the cart.
  void decrementItem(Product product) {
    if (_items.containsKey(product.id)) {
      // if item exists in cart, decrease the quantity
      _items.update(
        product.id,
            (existingCartItem) => existingCartItem.quantity > 1
            ? CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity - 1,
        )
            : throw Exception('Invalid operation. Quantity cannot be less than 1'),
      );
    }
    notifyListeners();
  }
}
