import 'package:flutter/material.dart';

class ShopTheme {
  static ThemeData android() {
    return ThemeData(
      primarySwatch: Colors.purple,
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: const TextStyle(color: Colors.white),
          ),
      inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
            labelStyle: const TextStyle(color: Colors.purple),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.purple,
                width: 2,
              ),
            ),
          ),
      colorScheme:
          ThemeData.light().colorScheme.copyWith(secondary: Colors.deepOrange),
      appBarTheme: ThemeData.light()
          .appBarTheme
          .copyWith(backgroundColor: Colors.purple),
      fontFamily: 'Lato',
    );
  }

  static ThemeData ios() {
    return ShopTheme.android();
  }
}
