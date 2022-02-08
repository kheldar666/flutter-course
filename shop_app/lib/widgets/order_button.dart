import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/cart.dart';
import '/providers/orders.dart';
import '/screens/order_screen.dart';

class OrderButton extends StatefulWidget {
  final Cart cart;
  const OrderButton(this.cart, {Key? key}) : super(key: key);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cart.items.isNotEmpty
          ? () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false)
                  .addOrder(widget.cart)
                  .then((_) {
                setState(() {
                  _isLoading = false;
                });
              });
              widget.cart.clear();
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            }
          : null,
      child: _isLoading
          ? const CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
    );
  }
}
