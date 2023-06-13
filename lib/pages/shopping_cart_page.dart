import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinefly_internship_app/services/providers/cart_provider.dart';
import 'package:cinefly_internship_app/widgets/global/custom_network_image.dart';

/// [ShoppingCartPage] is a widget that represents a shopping cart page.
///
/// This stateless widget uses the [CartProvider] to obtain the current state of the cart.
class ShoppingCartPage extends StatelessWidget {

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The UI consists of a list view that represents the cart items, where each item shows
  /// its image, name, quantity, and total price for that quantity. At the bottom of the page,
  /// the total amount of all items in the cart is shown.
  @override
  Widget build(BuildContext context) {
    // Using the Consumer widget to listen for changes in the CartProvider
    return Consumer<CartProvider>(
      // The builder method is called whenever the CartProvider changes
      builder: (ctx, cart, _) => Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
        ),
        body: Column(
          children: [
            // Display a list of all the items in the cart
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, index) {
                  // For each item in the cart, display its image, name, quantity, and total price
                  return ListTile(
                    // ------------------- BUG FIX START ------------------- //
                    // -------------------   BUG_00001   ------------------- //
                    // -------------------   BOZHAO LI   ------------------- //
                    // -------------------   13/06/2023  ------------------- //
                    leading: CustomNetworkImage(url: cart.items.values.toList()[index].product.imageUrl),
                    // ------------------- BUG FIX E N D ------------------- //
                    title: Text(cart.items.values.toList()[index].product.name),
                    subtitle: Text('Qty: ${cart.items.values.toList()[index].quantity.toString()}'),
                    trailing: Text("\$${(cart.items.values.toList()[index].product.price * cart.items.values.toList()[index].quantity).toStringAsFixed(2)}"),
                  );
                },
              ),
            ),
            // Display the total price of all the items in the cart
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
