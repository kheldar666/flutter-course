import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:uuid/uuid.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(Product product, double price) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingCartItem) {
        existingCartItem.quantity++;
        existingCartItem.price += price;
        return existingCartItem;
      });
    } else {
      _items.putIfAbsent(
          product.id, () => CartItem(product: product, price: price));
    }
  }
}

class CartItem {
  late final String _id;
  final Product product;
  int quantity;
  double price;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.price,
  }) {
    _id = const Uuid().v4().toString();
  }

  String get id => _id;
}
