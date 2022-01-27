import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' as cart;

class CartItem extends StatelessWidget {
  final cart.CartItem cartItem;
  const CartItem(this.cartItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<cart.Cart>(context, listen: false)
            .removeItem(cartItem.product.id);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                    child: Text(
                  '\$${cartItem.product.price}',
                )),
              ),
            ),
            title: Text(cartItem.product.title),
            subtitle:
                Text('Total: \$${cartItem.quantity * cartItem.product.price}'),
            trailing: Text('x ${cartItem.quantity}'),
          ),
        ),
      ),
    );
  }
}
