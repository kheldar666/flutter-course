import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

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
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      label: Text(
                        '\$${cart.totalPrice}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1
                              ?.color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
