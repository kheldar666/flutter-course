import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item.dart';

import '/providers/product.dart';

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

  void removeSingleItem(Product product) {
    if (_items.containsKey(product.id)) {
      if (_items[product.id]!.quantity > 1) {
        _items.update(product.id, (existingCartItem) {
          existingCartItem.quantity--;
          return existingCartItem;
        });
      } else {
        _items.remove(product.id);
      }
      notifyListeners();
    }
  }

  void removeCartItem(String cartItemId) {
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

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
