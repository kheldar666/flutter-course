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

  void toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await update();
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
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
