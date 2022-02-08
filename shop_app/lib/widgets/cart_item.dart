import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/cart.dart';

import '../models/cart_item.dart' as cart;

class CartItem extends StatelessWidget {
  final cart.CartItem cartItem;
  const CartItem(this.cartItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure ?'),
            content: const Text(
                'Do you really want to remove this item from the cart ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Yes'),
              )
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false)
            .removeCartItem(cartItem.product.id);
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
