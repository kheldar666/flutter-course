import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/constants.dart';
import '/exceptions/http_exception.dart';
import '/models/edit_product.dart';
import '/models/filter_option.dart';
import '/providers/product.dart';

class Products with ChangeNotifier {
  final _productsUrl = Uri.https(kFirebaseBaseDomain, '/products.json');

  //final List<Product> _products = kDummyProducts; // To use when no DB
  final List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  List<Product> getProducts(FilterOptions options) {
    if (options == FilterOptions.favorites) {
      return _products.where((product) => product.isFavorite).toList();
    }
    return products;
  }

  Future<void> fetchAndSetProducts() async {
    // Avoid to load several time the same products when
    // moving away and back to home page
    // Not great... but ok for now I guess
    _products.clear();
    try {
      final response = await http.get(_productsUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((productId, productData) {
          final fetchedProduct = Product.fromJson(productData);
          fetchedProduct.id = productId;
          _products.add(fetchedProduct);
        });
      }
      notifyListeners();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> addOrUpdateProduct(EditProduct product) async {
    Product addOrUpdateProduct = Product(
      id: product.id,
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    );
    int index = _products.indexWhere((p) => p.id == addOrUpdateProduct.id);

    if (index > -1) {
      try {
        final response = await addOrUpdateProduct.update();
        if (response.statusCode == 200) {
          _products.removeAt(index);
          _products.insert(index, addOrUpdateProduct);
          notifyListeners();
        }
      } on Exception catch (error) {
        rethrow;
      }
    } else {
      // Save the Product in Firebase
      try {
        final response = await http.post(_productsUrl,
            body: json.encode(addOrUpdateProduct.toJson()));

        if (response.statusCode == 200) {
          addOrUpdateProduct.id = json.decode(response.body)['name'];
          _products.add(addOrUpdateProduct);
          notifyListeners();
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index = _products.indexWhere((p) => p.id == product.id);
    if (index > -1) {
      // try {
      //   await http.delete(_productUrl(product.id));
      //   _products.removeAt(index);
      //   notifyListeners();
      // } on Exception catch (_) {
      //   rethrow;
      // }

      //Optimistic Updating
      _products.removeAt(index);
      notifyListeners();

      final response = await http.delete(product.productUrl);
      if (response.statusCode >= 400) {
        // We restore the product in memory if the delete failed
        // (what ever the reason)
        _products.insert(index, product);
        notifyListeners();
        throw HttpException('Could not delete the product');
      }
    }
  }

  Product findById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }
}
