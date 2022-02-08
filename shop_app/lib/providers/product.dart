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

    final favoritesUrl = Uri.https(
        kFirebaseDBBaseDomain, '/favorites/$userId/$id.json', {'auth': token});

    try {
      final response =
          await http.put(favoritesUrl, body: json.encode(isFavorite));
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

  Uri get productUrl => Uri.https(kFirebaseDBBaseDomain, '/products/$id.json');

  Future<http.Response> update() async {
    return await http.patch(productUrl, body: json.encode(toJson()));
  }
}
