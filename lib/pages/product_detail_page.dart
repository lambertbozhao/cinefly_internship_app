import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinefly_internship_app/services/providers/cart_provider.dart';
import 'package:cinefly_internship_app/services/models/product.dart';

/// [ProductDetailPage] is a widget that displays detailed information about a product.
///
/// It receives a [Product] object as a required parameter, and it uses this object to display
/// the product's image, name, description, and price. There's also a button to add the product
/// to the shopping cart.
class ProductDetailPage extends StatelessWidget {
  /// [Product] object that contains the information to be displayed on the detail page.
  final Product product;
  /// Default constructor for this class, requires a [Product] object.
  ProductDetailPage({required this.product});

  /// Describes the part of the user interface represented by this widget.
  ///
  /// It includes an [AppBar] with the product name, and a [Column] that contains widgets
  /// displaying the product's image, name, description, price, and a "Add to Cart" button.
  /// When this button is tapped, the current [Product] object is added to the shopping cart
  /// via the [CartProvider].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Image.network(product.imageUrl),
              SizedBox(height: 10.0),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  // Add to cart action
                  Provider.of<CartProvider>(context, listen: false).addItem(product);
                },
                child: Text("Add to Cart"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
