import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/order_item.dart';

import '/providers/cart.dart';

class Orders with ChangeNotifier {
  final _ordersUrl = Uri.https(kFirebaseBaseDomain, '/orders.json');

  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  void addOrder(Cart cart) {
    //Adds always at the top
    _orders.insert(
      0,
      OrderItem(
        amount: cart.totalPrice,
        contents: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
