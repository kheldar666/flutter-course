import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Product with ChangeNotifier {
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

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
