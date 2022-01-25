import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/data/dummy_data.dart';
import 'package:menu_app/models/category.dart' as meal_category;
import 'package:menu_app/models/filters.dart';
import 'package:menu_app/models/meal.dart';
import 'package:menu_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';

  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late meal_category.Category _category;
  late Filters _filters;
  late List<Meal> _filteredMeals;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _category = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Object>)['category'] as meal_category.Category;
    _filters = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Object>)['filters'] as Filters;
    _filteredMeals = _filterMeals(_category.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('$kAppBarTitle - ${_category.title}'),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(_filteredMeals[index], callback: _removeMeal);
          },
          itemCount: _filteredMeals.length,
        ),
      ),
    );
  }

  void _removeMeal(String excludeMealId) {
    if (kDebugMode) {
      print('refreshMeals: excludeMealId = $excludeMealId');
    }
    setState(() {
      _filteredMeals.removeWhere((meal) => meal.id == excludeMealId);
    });
  }

  List<Meal> _filterMeals(String categoryId) {
    print(_filters);
    return kDummyMeals
        .where((meal) => meal.categories.contains(categoryId))
        .where((meal) => _filters.glutenFree
            ? meal.isGlutenFree == _filters.glutenFree
            : true)
        .where((meal) => _filters.vegetarian
            ? meal.isVegetarian == _filters.vegetarian
            : true)
        .where((meal) => _filters.vegan ? meal.isVegan == _filters.vegan : true)
        .where((meal) => _filters.lactoseFree
            ? meal.isLactoseFree == _filters.lactoseFree
            : true)
        .toList();
  }
}
