import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1
                              ?.color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      onPressed: cart.items.isNotEmpty
                          ? () {
                              Provider.of<Orders>(context, listen: false)
                                  .addOrder(cart);
                              cart.clear();
                              Navigator.of(context)
                                  .pushNamed(OrdersScreen.routeName);
                            }
                          : null,
                      child: cart.items.isNotEmpty
                          ? Text(
                              'ORDER NOW',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) =>
                    CartItem(cart.items.values.toList()[index]),
                itemCount: cart.items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
