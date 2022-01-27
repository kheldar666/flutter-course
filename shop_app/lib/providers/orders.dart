import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:uuid/uuid.dart';

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  void addOrder(Cart cart) {
    //Adds always at the top
    _orders.insert(
      0,
      OrderItem(
        amount: cart.totalPrice,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}

class OrderItem {
  late final String id;
  final double amount;
  final List<CartItem> products;
  late final DateTime dateTime;
  OrderItem({
    required this.amount,
    required this.products,
  }) {
    id = const Uuid().v4().toString();
    dateTime = DateTime.now();
  }
}
