import 'package:flutter/material.dart';
import 'package:menu_app/constants.dart';
import 'package:menu_app/meal_theme.dart';
import 'package:menu_app/screens/categories_screen.dart';
import 'package:menu_app/screens/category_meals_screen.dart';
import 'package:menu_app/screens/favorites_screen.dart';
import 'package:menu_app/screens/meal_detail_screen.dart';
import 'package:menu_app/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: MealTheme.android(),
      initialRoute: TabsScreen.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
        TabsScreen.routeName: (ctx) => const TabsScreen(),
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        //Fallback Route in case there is an unknown Route passed
        return MaterialPageRoute(builder: (ctx) => const TabsScreen());
      },
    );
  }
}
