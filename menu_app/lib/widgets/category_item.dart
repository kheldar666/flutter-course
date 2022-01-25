import 'package:flutter/material.dart';
import 'package:menu_app/models/category.dart';
import 'package:menu_app/models/filters.dart';
import 'package:menu_app/models/meal.dart';
import 'package:menu_app/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  final List<Meal> availableMeals;

  const CategoryItem(this.category, this.availableMeals, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.7),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
    );
  }

  void _selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {'category': category, 'meals': availableMeals},
    );
  }
}
