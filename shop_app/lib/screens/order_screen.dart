import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item.dart';

import '/providers/orders.dart' show Orders;
import '/widgets/shop_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;

  @override
  void initState() {
    _ordersFuture = Provider.of<Orders>(context, listen: false).fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const ShopDrawer(),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.hasError) {
                return const Center(
                  child: Text('An Error as Occurred'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => orderData
                          .orders.isNotEmpty
                      ? ListView.builder(
                          itemCount: orderData.orders.length,
                          itemBuilder: (ctx, i) =>
                              OrderItem(orderData.orders[i]),
                        )
                      : const Center(child: Text('You have no orders yet.')),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
