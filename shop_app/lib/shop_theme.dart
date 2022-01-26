import 'package:flutter/material.dart';

class ShopTheme {
  static ThemeData android() {
    return ThemeData(
      primarySwatch: Colors.purple,
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
