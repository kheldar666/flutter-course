import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/exceptions/auth_exception.dart';

import '/exceptions/http_exception.dart';
import '/models/edit_product.dart';
import '/models/filter_option.dart';
import '/providers/product.dart';

class Products with ChangeNotifier {
  final List<Product> _products;

  final String? _authToken;
  final String _userId;

  Products(this._authToken, this._userId, this._products);

  List<Product> get products {
    return [..._products];
  }

  List<Product> getProducts(FilterOptions options) {
    if (options == FilterOptions.favorites) {
      return _products.where((product) => product.isFavorite).toList();
    }
    return products;
  }

  Future<void> fetchAndSetProducts({bool filterByUser = false}) async {
    // Avoid to load several time the same products when
    // moving away and back to home page
    // Not great... but ok for now I guess
    _products.clear();
    try {
      final productsRes = await http.get(filterByUser
          ? Product.filteredProductsUrl(_authToken, _userId)
          : Product.productsUrl(_authToken));
      final favoritesRes =
          await http.get(Product.favoritesUrl(_authToken, _userId));
      if (productsRes.statusCode == 200 && favoritesRes.statusCode == 200) {
        final productsData =
            json.decode(productsRes.body) as Map<String, dynamic>;
        final favoritesData = json.decode(favoritesRes.body);

        productsData.forEach((productId, productData) {
          final fetchedProduct = Product.fromJson(productData);
          fetchedProduct.id = productId;
          fetchedProduct.isFavorite =
              favoritesData == null ? false : favoritesData[productId] ?? false;
          _products.add(fetchedProduct);
        });
        notifyListeners();
      } else {
        if (productsRes.statusCode == 401) {
          throw AuthException(json.decode(productsRes.body)['error']);
        }
      }
    } catch (_) {
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
      creatorId: _userId,
    );
    int index = _products.indexWhere((p) => p.id == addOrUpdateProduct.id);

    if (index > -1) {
      try {
        final response = await addOrUpdateProduct.update(_authToken);
        if (response.statusCode == 200) {
          _products.removeAt(index);
          _products.insert(index, addOrUpdateProduct);
          notifyListeners();
        }
      } catch (error) {
        rethrow;
      }
    } else {
      // Save the Product in Firebase
      try {
        final response = await http.post(Product.productsUrl(_authToken),
            body: json.encode(addOrUpdateProduct.toJson()));

        if (response.statusCode == 200) {
          addOrUpdateProduct.id = json.decode(response.body)['name'];
          _products.add(addOrUpdateProduct);
          notifyListeners();
        }
      } catch (_) {
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index = _products.indexWhere((p) => p.id == product.id);
    if (index > -1) {
      //Optimistic Updating
      _products.removeAt(index);
      notifyListeners();

      final response = await http.delete(product.productUrl(_authToken));
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
