import 'dart:convert';
import 'package:cinefly_internship_app/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:cinefly_internship_app/services/models/product.dart';

/// A StatefulWidget that displays a list of products.
/// The Widget rebuilds every time setState() gets called.
class ProductListPage extends StatefulWidget {
  /// Creates the ProductListPage StatefulWidget.
  ProductListPage();

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

/// The logic and internal state for a StatefulWidget.
class _ProductListPageState extends State<ProductListPage> {
  /// A list to store products.
  List<Product> products = [];

  /// Initial state of the widget.
  /// I am using it to load the product data asynchronously.
  @override
  void initState() {
    super.initState();
    // Load the product data
    _loadProducts();
  }

  /// Loads products from a json file.
  /// It retrieves the data, parses the JSON, and updates the state.
  _loadProducts() async {
    // Load the JSON file from the assets.
    String data =
    await DefaultAssetBundle.of(context).loadString("assets/data/catalogue.json");
    // Decode the JSON.
    final jsonResult = json.decode(data);
    // Get the list of products.
    var productsJson = jsonResult['products'] as List;
    // Update the state with the new list of products.
    setState(() {
      products = productsJson.map((i) => Product.fromJson(i)).toList();
    });
  }

  /// Describes the part of the user interface represented by this widget.
  /// It's called when this object is inserted into the tree as well.
  @override
  Widget build(BuildContext context) {
    // Returns a Material Design visual layout structure.
    return Scaffold(
      // Application top bar.
      appBar: AppBar(
        title: Text('Product List'),
      ),
      // Body of the scaffold which represents main content.
      body: ListView.builder(
        // The number of items to display.
        itemCount: products.length,
        // Provides a function to build each child in the list.
        itemBuilder: (context, index) {
          // Display a ListTile widget for each Product.
          return ListTile(
            leading: Image.network(products[index].imageUrl),
            title: Text(products[index].name),
            subtitle: Text(products[index].description),
            trailing: Text("\$${products[index].price.toStringAsFixed(2)}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}