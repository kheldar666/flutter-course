import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/order.dart';

import '/providers/cart.dart';

class Orders with ChangeNotifier {
  final _ordersUrl = Uri.https(kFirebaseBaseDomain, '/orders.json');

  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(Cart cart) {
    final order = Order(
      amount: cart.totalPrice,
      contents: cart.items.values.toList(),
    );
    //Adds always at the top
    _orders.insert(
      0,
      order,
    );
    notifyListeners();
  }
}
