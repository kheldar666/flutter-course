import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/meal_theme.dart';
import 'package:menu_app/screens/categories_screen.dart';
import 'package:menu_app/screens/category_meals_screen.dart';
import 'package:menu_app/screens/meal_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: MealTheme.android(),
      initialRoute: CategoriesScreen.routeName,
      routes: {
        CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
        CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
