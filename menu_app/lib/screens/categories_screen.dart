import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/data/dummy_data.dart';
import 'package:menu_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  static String routeName = '/';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('$kAppBarTitle - Categories'),
        ),
        body: GridView(
          padding: const EdgeInsets.all(25),
          children: [
            ...kDummyCategories.map((category) => CategoryItem(category))
          ],
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
        ),
      ),
    );
  }
}
