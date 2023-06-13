import 'package:flutter/material.dart';
import 'package:cinefly_internship_app/pages/product_list_page.dart';
import 'package:cinefly_internship_app/pages/shopping_cart_page.dart';

/// [HomePage] is a widget that acts as the root of the application. It's a stateful widget that
/// maintains the state of the selected index from the bottom navigation bar and displays the
/// corresponding page.
class HomePage extends StatefulWidget {
  /// Creates the mutable state for this widget.
  @override
  _HomePageState createState() => _HomePageState();
}

/// The [_HomePageState] class is the mutable state for [HomePage].
class _HomePageState extends State<HomePage> {
  // Current selected index of the bottom navigation bar
  int _selectedIndex = 0;
  // List of pages for the corresponding index of the bottom navigation bar
  final List<Widget> _widgetOptions = <Widget>[
    ProductListPage(),
    ShoppingCartPage(),
  ];

  /// Updates the state of [_selectedIndex] when an item is tapped in the bottom navigation bar.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Describes the part of the user interface represented by this widget.
  ///
  /// It includes an [AppBar] at the top, the selected page from [_widgetOptions]
  /// in the middle, and a [BottomNavigationBar] at the bottom.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecommerce App'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
