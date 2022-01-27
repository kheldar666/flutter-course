import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/models/filter_option.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  final List<Product> _products = kDummyProducts;

  List<Product> get products {
    return [..._products];
  }

  List<Product> getProducts(FilterOptions options) {
    if (options == FilterOptions.favorites) {
      return _products.where((product) => product.isFavorite).toList();
    }
    return products;
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  Product findById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }
}
