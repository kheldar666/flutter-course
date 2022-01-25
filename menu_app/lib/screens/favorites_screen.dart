import 'package:flutter/material.dart';
import 'package:menu_app/models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoritesScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('You have no favorites - start adding some!'),
    );
  }
}
