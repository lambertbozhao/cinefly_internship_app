import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinefly_internship_app/services/providers/cart_provider.dart';
import 'package:cinefly_internship_app/services/providers/orders_provider.dart';
import 'package:cinefly_internship_app/widgets/global/custom_network_image.dart';

/// [ShoppingCartPage] is a widget that represents a shopping cart page.
///
/// This stateless widget uses the [CartProvider] to obtain the current state of the cart.
class ShoppingCartPage extends StatefulWidget {
  /// Default constructor for this class.
  ShoppingCartPage();

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();

}

/// The logic and internal state for a StatefulWidget.
class _ShoppingCartPageState extends State<ShoppingCartPage> {

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
                    subtitle: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (cart.items.values.toList()[index].quantity > 1) {
                              cart.decrementItem(cart.items.values.toList()[index].product);
                            }
                          },
                        ),
                        Text(cart.items.values.toList()[index].quantity.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            cart.incrementItem(cart.items.values.toList()[index].product);
                          },
                        ),
                      ],
                    ),
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

/// [OrderButton] is a StatefulWidget which contains a button for placing an order.
///
/// This widget gets the current cart information via a [CartProvider] object.
/// It also maintains an internal state [_isLoading] which determines whether
/// the order placing process is ongoing or not.
class OrderButton extends StatefulWidget {
  /// The current cart information.
  final CartProvider cart;

  /// The constructor requires a [CartProvider] object.
  OrderButton(this.cart);

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

/// [_OrderButtonState] is the state for [OrderButton] widget.
///
/// This class includes the UI and behavior of the [OrderButton].
/// It also defines the behavior when the 'ORDER NOW' button is pressed.
/// While an order is being placed, it shows a loading spinner, and
/// once the order is placed, it shows 'ORDER NOW'.
class _OrderButtonState extends State<OrderButton> {
  /// Determines whether the order is being placed or not.
  var _isLoading = false;

  /// Describes the part of the user interface represented by this widget.
  ///
  /// If the order is being placed, it shows a [CircularProgressIndicator], otherwise
  /// it shows a [Text] widget with 'ORDER NOW'.
  /// It also defines the behavior when the 'ORDER NOW' button is pressed.
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<OrdersProvider>(context, listen: false)
            .addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount);
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
    );
  }
}