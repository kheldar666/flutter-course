import 'package:flutter/material.dart';
import 'package:menu_app/models/meal.dart';
import 'package:menu_app/widgets/meal_detail.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal/detail';

  final void Function(Meal) toggleFavorite;

  final bool Function(Meal) isFavoriteMeal;

  const MealDetailScreen(this.toggleFavorite, this.isFavoriteMeal, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _meal = (ModalRoute.of(context)?.settings.arguments
        as Map<String, dynamic>)['meal'] as Meal;

    final _showHideAction = (ModalRoute.of(context)?.settings.arguments
        as Map<String, dynamic>)['showHideAction'] as bool;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_meal.title),
          actions: [
            _showHideAction
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(_meal.id);
                    },
                    icon: const Icon(Icons.hide_image),
                  )
                : Container(),
          ],
        ),
        body: MealDetail(_meal),
        floatingActionButton: FloatingActionButton(
          onPressed: () => toggleFavorite(_meal),
          child: Icon(
              isFavoriteMeal(_meal) ? Icons.favorite : Icons.favorite_border),
        ),
      ),
    );
  }
}
