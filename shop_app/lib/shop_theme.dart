import 'package:flutter/material.dart';

class ShopTheme {
  static ThemeData android() {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  static ThemeData ios() {
    return ShopTheme.android();
  }
}
