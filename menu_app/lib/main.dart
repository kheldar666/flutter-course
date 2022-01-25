import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/data/dummy_data.dart';
import 'package:menu_app/meal_theme.dart';
import 'package:menu_app/models/filters.dart';
import 'package:menu_app/screens/category_meals_screen.dart';
import 'package:menu_app/screens/filters_screen.dart';
import 'package:menu_app/screens/meal_detail_screen.dart';
import 'package:menu_app/screens/tabs_screen.dart';

import 'package:menu_app/models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Filters _filters = Filters();

  List<Meal> _availableMeals = kDummyMeals;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: MealTheme.android(),
      initialRoute: TabsScreen.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
        TabsScreen.routeName: (ctx) => TabsScreen(_availableMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, setFilters),
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        //Fallback Route in case there is an unknown Route passed
        return MaterialPageRoute(builder: (ctx) => TabsScreen(_availableMeals));
      },
    );
  }

  void setFilters(Filters filters) {
    setState(() {
      _filters.lactoseFree = filters.lactoseFree;
      _filters.vegetarian = filters.vegetarian;
      _filters.vegan = filters.vegan;
      _filters.glutenFree = filters.glutenFree;

      _availableMeals = _availableMeals
          .where((meal) => _filters.glutenFree
              ? meal.isGlutenFree == _filters.glutenFree
              : true)
          .where((meal) => _filters.vegetarian
              ? meal.isVegetarian == _filters.vegetarian
              : true)
          .where(
              (meal) => _filters.vegan ? meal.isVegan == _filters.vegan : true)
          .where((meal) => _filters.lactoseFree
              ? meal.isLactoseFree == _filters.lactoseFree
              : true)
          .toList();
    });
  }
}
