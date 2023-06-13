import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinefly_internship_app/services/providers/cart_provider.dart';
import 'package:cinefly_internship_app/services/models/product.dart';
import 'package:cinefly_internship_app/widgets/global/custom_network_image.dart';

/// [ProductDetailPage] is a widget that displays detailed information about a product.
///
/// It receives a [Product] object as a required parameter, and it uses this object to display
/// the product's image, name, description, and price. There's also a button to add the product
/// to the shopping cart.
class ProductDetailPage extends StatefulWidget {
  /// [Product] object that contains the information to be displayed on the detail page.
  final Product product;

  /// Default constructor for this class, requires a [Product] object.
  ProductDetailPage({required this.product});

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();

}

/// The logic and internal state for a StatefulWidget.
class _ProductDetailPageState extends State<ProductDetailPage> {
  /// An integer variable that will keep track of the selected quantity
  int _quantity = 1;

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
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              // ------------------- BUG FIX START ------------------- //
              // -------------------   BUG_00001   ------------------- //
              // -------------------   BOZHAO LI   ------------------- //
              // -------------------   13/06/2023  ------------------- //
              Hero(
                tag: 'product-image-${widget.product.id}',
                child: CustomNetworkImage(url: widget.product.imageUrl),
              ),
              // CustomNetworkImage(url: product.imageUrl),
              // ------------------- BUG FIX E N D ------------------- //
              SizedBox(height: 10.0),
              Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "\$${widget.product.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                  ),
                  Text(_quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  // Add to cart action
                  Provider.of<CartProvider>(context, listen: false).addItem(widget.product, _quantity);
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
