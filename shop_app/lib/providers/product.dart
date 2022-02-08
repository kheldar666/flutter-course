import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:shop_app/constants.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product with ChangeNotifier {
  @JsonKey(ignore: true)
  late String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;

  @JsonKey(ignore: true)
  bool isFavorite;

  Product({
    this.id = '',
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  }) {
    if (id.isEmpty) id = const Uuid().v4().toString();
  }

  void _resetFavorite(bool oldValue) {
    isFavorite = oldValue;
    notifyListeners();
  }

  void toggleFavorite(String? token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.put(favoriteUrl(token, userId),
          body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        _resetFavorite(oldStatus);
      }
    } catch (e) {
      _resetFavorite(oldStatus);
    }
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Future<http.Response> update(String? token) async {
    return await http.patch(productUrl(token), body: json.encode(toJson()));
  }

  static Uri productsUrl(String? token) =>
      Uri.https(kFirebaseDBBaseDomain, '/products.json', {'auth': token});

  Uri productUrl(String? token) =>
      Uri.https(kFirebaseDBBaseDomain, '/products/$id.json', {'auth': token});

  static Uri favoritesUrl(String? token, String userId) => Uri.https(
      kFirebaseDBBaseDomain, '/favorites/$userId.json', {'auth': token});

  Uri favoriteUrl(String? token, String userId) => Uri.https(
      kFirebaseDBBaseDomain, '/favorites/$userId/$id.json', {'auth': token});
}
