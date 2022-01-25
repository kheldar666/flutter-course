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
  late List<Meal> _availableMeals;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _category = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Object>)['category'] as meal_category.Category;

    _availableMeals = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Object>)['meals'] as List<Meal>;

    _filterMeals(_category.id);
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
            return MealItem(_availableMeals[index], callback: _removeMeal);
          },
          itemCount: _availableMeals.length,
        ),
      ),
    );
  }

  void _removeMeal(String excludeMealId) {
    if (kDebugMode) {
      print('refreshMeals: excludeMealId = $excludeMealId');
    }
    setState(() {
      _availableMeals.removeWhere((meal) => meal.id == excludeMealId);
    });
  }

  void _filterMeals(String categoryId) {
    _availableMeals
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
  }
}
