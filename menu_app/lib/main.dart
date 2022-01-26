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

  List<Meal> _availableMeals = kDummyMeals.map((meal) => meal).toList();

  final List<Meal> _favoriteMeals = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: MealTheme.android(),
      initialRoute: TabsScreen.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavoriteMeal),
        TabsScreen.routeName: (ctx) => TabsScreen(_favoriteMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
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

  void _setFilters(Filters filters) {
    setState(() {
      _filters.lactoseFree = filters.lactoseFree;
      _filters.vegetarian = filters.vegetarian;
      _filters.vegan = filters.vegan;
      _filters.glutenFree = filters.glutenFree;

      _availableMeals = kDummyMeals.map((meal) => meal).toList();

      _availableMeals.removeWhere((meal) => _filters.glutenFree
          ? meal.isGlutenFree != _filters.glutenFree
          : false);
      _availableMeals.removeWhere((meal) => _filters.vegetarian
          ? meal.isVegetarian != _filters.vegetarian
          : false);
      _availableMeals.removeWhere(
          (meal) => _filters.vegan ? meal.isVegan != _filters.vegan : false);
      _availableMeals.removeWhere((meal) => _filters.lactoseFree
          ? meal.isLactoseFree != _filters.lactoseFree
          : false);
    });
  }

  void _toggleFavorite(Meal _meal) {
    final _existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == _meal.id);
    if (_isFavoriteMeal(_meal)) {
      setState(() {
        _favoriteMeals.removeAt(_existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(_meal);
      });
    }
  }

  bool _isFavoriteMeal(Meal _meal) {
    return _favoriteMeals.any((meal) => meal.id == _meal.id);
  }
}
