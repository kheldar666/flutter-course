import 'package:flutter/material.dart';
import 'package:menu_app/data/dummy_data.dart';
import 'package:menu_app/models/filters.dart';
import 'package:menu_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  final Filters filters;
  const CategoriesScreen(this.filters, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: [
        ...kDummyCategories.map((category) => CategoryItem(category, filters))
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
