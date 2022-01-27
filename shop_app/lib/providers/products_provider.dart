import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _products = kDummyProducts;

  List<Product> get products => [..._products];

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  Product findById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }
}