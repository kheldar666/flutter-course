import 'package:flutter/material.dart';
import 'package:menu_app/models/category.dart';

class CategoryMealsScreen extends StatelessWidget {
  final Category category;
  const CategoryMealsScreen(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('DeliMeals - ${category.title}'),
        ),
        body: Center(
          child: Text('The recipes for the category : ${category.title}'),
        ),
      ),
    );
  }
}
