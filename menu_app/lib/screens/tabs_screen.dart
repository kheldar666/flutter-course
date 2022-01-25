import 'package:flutter/material.dart';
import 'package:menu_app/screens/categories_screen.dart';
import 'package:menu_app/screens/favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/home-tabs';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Meals'),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.category),
                    text: 'Categories',
                  ),
                  Tab(
                    icon: Icon(Icons.favorite),
                    text: 'Favorites',
                  )
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                CategoriesScreen(),
                FavoritesScreen(),
              ],
            ),
          )),
    );
    return const SafeArea(child: Scaffold());
  }
}
