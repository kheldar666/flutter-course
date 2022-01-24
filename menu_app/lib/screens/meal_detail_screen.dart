import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/models/meal.dart';
import 'package:menu_app/widgets/meal_detail.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal/detail';

  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_meal.title),
        ),
        body: MealDetail(_meal),
      ),
    );
    ;
  }
}
