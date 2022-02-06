import 'package:flutter/material.dart';
import '/data/dummy_data.dart';
import '/models/edit_product.dart';
import '/models/filter_option.dart';
import '/providers/product.dart';

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
