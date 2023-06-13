import 'dart:convert';
import 'package:cinefly_internship_app/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:cinefly_internship_app/services/models/product.dart';
import 'package:cinefly_internship_app/widgets/global/custom_network_image.dart';

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

  /// Add a TextEditingController
  final TextEditingController _filter = TextEditingController();

  /// A filtered list of products
  List<Product> filteredProducts = [];

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
      filteredProducts = products;
    });
  }

  /// Create a method to filter your products.
  /// Call this method every time the text in the search field changes.
  void _filterProducts() {
    String searchText = _filter.text.toLowerCase();
    setState(() {
      filteredProducts = products
          .where((product) => product.name.toLowerCase().contains(searchText))
          .toList();
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
        title: TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...'
          ),
          onChanged: (value) {
            _filterProducts();
          },
        ),
      ),
      // Body of the scaffold which represents main content.
      body: ListView.builder(
        // The number of items to display.
        itemCount: filteredProducts.length,
        // Provides a function to build each child in the list.
        itemBuilder: (context, index) {
          // Display a ListTile widget for each Product.
          return ListTile(
            // ------------------- BUG FIX START ------------------- //
            // -------------------   BOZHAO LI   ------------------- //
            // -------------------   13/06/2023  ------------------- //
            leading: CustomNetworkImage(url: filteredProducts[index].imageUrl),
            // ------------------- BUG FIX E N D ------------------- //
            title: Text(filteredProducts[index].name),
            subtitle: Text(filteredProducts[index].description),
            trailing: Text("\$${filteredProducts[index].price.toStringAsFixed(2)}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: filteredProducts[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}