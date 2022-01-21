import 'package:flutter/material.dart';
import 'package:menu_app/models/category.dart';

class CategoryMealsScreen extends StatelessWidget {
  static String routeName = '/category-meals';
  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _category = ModalRoute.of(context)?.settings.arguments as Category;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('DeliMeals - ${_category.title}'),
        ),
        body: Center(
          child: Text('The recipes for the category : ${_category.title}'),
        ),
      ),
    );
  }
}
