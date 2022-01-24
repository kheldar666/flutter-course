import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal/detail';

  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('$kAppBarTitle - ${_meal.title}'),
        ),
        body: const Center(child: Text('The Meal')),
      ),
    );
    ;
  }
}
