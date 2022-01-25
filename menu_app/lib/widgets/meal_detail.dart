import 'package:flutter/material.dart';
import 'package:menu_app/models/meal.dart';

class MealDetail extends StatelessWidget {
  final Meal meal;
  const MealDetail(this.meal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          _buildSectionTitle(context, 'Ingredients'),
          _buildList(ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(meal.ingredients[index]),
                ),
              );
            },
            itemCount: meal.ingredients.length,
          )),
          _buildSectionTitle(context, 'Steps'),
          _buildList(ListView.builder(
            itemBuilder: (ctx, index) => Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Text('#${index + 1}'),
                  ),
                  title: Text(meal.steps[index]),
                ),
                const Divider()
              ],
            ),
            itemCount: meal.steps.length,
          )),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildList(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      height: 200,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 300,
      child: Scrollbar(
        child: child,
      ),
    );
  }
}
