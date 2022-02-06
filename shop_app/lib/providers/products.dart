import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/models/edit_product.dart';
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

  void addOrUpdateProduct(EditProduct product) {
    Product addOrUpdateProduct = Product(
      id: product.id,
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    );
    int index = _products.indexWhere((p) => p.id == addOrUpdateProduct.id);

    if (index > -1) {
      _products.removeAt(index);
      _products.insert(index, addOrUpdateProduct);
    } else {
      _products.add(addOrUpdateProduct);
    }
    notifyListeners();
  }

  Product findById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }

  void deleteProduct(Product product) {
    int index = _products.indexWhere((p) => p.id == product.id);

    if (index > -1) {
      _products.removeAt(index);
    }
    notifyListeners();
  }
}
