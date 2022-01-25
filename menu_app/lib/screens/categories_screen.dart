import 'package:flutter/material.dart';
import 'package:menu_app/data/dummy_data.dart';
import 'package:menu_app/models/meal.dart';
import 'package:menu_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Meal> availableMeals;
  const CategoriesScreen(this.availableMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: [
        ...kDummyCategories
            .map((category) => CategoryItem(category, availableMeals))
      ],
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
