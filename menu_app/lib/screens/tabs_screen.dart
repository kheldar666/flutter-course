import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/models/filters.dart';
import 'package:menu_app/models/meal.dart';
import 'package:menu_app/screens/categories_screen.dart';
import 'package:menu_app/screens/favorites_screen.dart';
import 'package:menu_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/home-tabs';

  final List<Meal> availableMeals;

  const TabsScreen(this.availableMeals, {Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> _pages = [
      {'title': 'Categories', 'page': CategoriesScreen(widget.availableMeals)},
      {'title': 'Your Favorites', 'page': const FavoritesScreen()},
    ];

    if (kShowTabAtTheTop) {
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
              body: TabBarView(
                children: [
                  CategoriesScreen(widget.availableMeals),
                  const FavoritesScreen(),
                ],
              ),
            )),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(_pages[_currentPage]['title'] as String),
          ),
          drawer: const MainDrawer(),
          body: _pages[_currentPage]['page'] as Widget,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentPage,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Colors.white,
            //type: BottomNavigationBarType.shifting,
            onTap: _selectPage,
            items: [
              BottomNavigationBarItem(
                backgroundColor:
                    Theme.of(context).primaryColor, // Used for shifting
                icon: const Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                backgroundColor:
                    Theme.of(context).primaryColor, // Used for shifting
                icon: const Icon(Icons.favorite),
                label: 'Favorites',
              )
            ],
          ),
        ),
      );
    }
  }

  void _selectPage(int newIndex) {
    setState(() {
      _currentPage = newIndex;
    });
  }
}
