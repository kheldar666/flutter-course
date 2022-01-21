import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/data/dummy_data.dart';
import 'package:menu_app/models/category.dart';
import 'package:menu_app/models/meal.dart';
import 'package:menu_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static String routeName = '/category-meals';

  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _category = ModalRoute.of(context)?.settings.arguments as Category;

    final _filteredMeals = _filterMeals(_category.id);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('$kAppBarTitle - ${_category.title}'),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(_filteredMeals[index]);
          },
          itemCount: _filteredMeals.length,
        ),
      ),
    );
  }

  List<Meal> _filterMeals(String categoryId) {
    return kDummyMeals
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
  }
}
