import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:uuid/uuid.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingCartItem) {
        existingCartItem.quantity++;
        return existingCartItem;
      });
    } else {
      _items.putIfAbsent(product.id, () => CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(String cartItemId) {
    _items.remove(cartItemId);
    notifyListeners();
  }

  int get countQuantity {
    var _count = 0;
    _items.forEach((_, items) {
      _count += items.quantity;
    });
    return _count;
  }

  double get totalPrice {
    var _totalPrice = 0.0;
    _items.forEach((_, items) {
      _totalPrice += items.product.price * items.quantity;
    });
    return _totalPrice;
  }
}

class CartItem {
  late final String _id;
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1}) {
    _id = const Uuid().v4().toString();
  }

  String get id => _id;
}
