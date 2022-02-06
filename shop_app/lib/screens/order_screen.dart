import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/orders.dart' show Orders;
import '/widgets/order_item.dart';
import '/widgets/shop_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const ShopDrawer(),
        body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
        ),
      ),
    );
  }
}
