import 'package:flutter/material.dart';
import 'package:menu_app/meal_theme.dart';
import 'package:menu_app/screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: MealTheme.android(),
      home: const CategoriesScreen(),
    );
  }
}
