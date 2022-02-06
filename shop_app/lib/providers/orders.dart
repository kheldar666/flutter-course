import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/order.dart';

import '/providers/cart.dart';

class Orders with ChangeNotifier {
  final _ordersUrl = Uri.https(kFirebaseBaseDomain, '/orders.json');

  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<void> addOrder(Cart cart) async {
    final order = Order(
      amount: cart.totalPrice,
      contents: cart.items.values.toList(),
    );

    final response = await order.save();
    if (response.statusCode == 200) {
      order.id = json.decode(response.body)['name'];
      //Adds always at the top
      _orders.insert(
        0,
        order,
      );
      notifyListeners();
    }
  }

  Future<void> fetchOrders() async {
    _orders.clear();
    try {
      final response = await http.get(_ordersUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((orderId, orderData) {
          final fetchedOrder = Order.fromJson(orderData);
          fetchedOrder.id = orderId;
          _orders.insert(0, fetchedOrder);
        });
      }
      notifyListeners();
    } on Exception catch (_) {
      rethrow;
    }
  }
}
