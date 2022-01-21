import 'package:flutter/material.dart';

class MealTheme {
  static ThemeData android() {
    return ThemeData(
      primarySwatch: Colors.pink,
      colorScheme:
          ThemeData.light().colorScheme.copyWith(secondary: Colors.amber),
      canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      fontFamily: 'Raleway',
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            color: Colors.pink,
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
            ),
          ),
      textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline1: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
          )),
    );
  }

  static ThemeData ios() {
    return MealTheme.android();
  }
}
