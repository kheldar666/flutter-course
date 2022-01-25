import 'package:flutter/material.dart';
import 'package:menu_app/screens/filters_screen.dart';
import 'package:menu_app/screens/tabs_screen.dart';
import 'package:menu_app/widgets/main_drawer_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Cooking up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MainDrawerItem(
            label: 'Meals',
            iconData: Icons.restaurant,
            onTap: () {
              // Using pushReplacementNamed allows to clean up the stack
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
          ),
          MainDrawerItem(
            label: 'Filters',
            iconData: Icons.settings,
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
