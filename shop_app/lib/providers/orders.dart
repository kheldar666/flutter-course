import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/constants.dart';
import '/models/order.dart';
import '/providers/cart.dart';

class Orders with ChangeNotifier {
  late Uri _ordersUrl;

  final String? _authToken;
  final String _userId;
  final List<Order> _orders;

  Orders(this._authToken, this._userId, this._orders) {
    _ordersUrl = Uri.https(
      kFirebaseDBBaseDomain,
      '/orders/$_userId.json',
      {
        'auth': _authToken,
      },
    );
  }

  List<Order> get orders => [..._orders];

  Future<void> addOrder(Cart cart) async {
    final order =
        Order(amount: cart.totalPrice, contents: cart.items.values.toList());

    final response = await order.save(_ordersUrl);

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
        final data = json.decode(response.body) as Map<String, dynamic>?;
        if (data != null) {
          data.forEach((orderId, orderData) {
            final fetchedOrder = Order.fromJson(orderData);
            fetchedOrder.id = orderId;
            _orders.insert(0, fetchedOrder);
          });
        }
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
