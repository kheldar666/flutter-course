import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData android() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      colorScheme:
          ThemeData.light().colorScheme.copyWith(secondary: Colors.amber),
      appBarTheme: ThemeData.light()
          .appBarTheme
          .copyWith(backgroundColor: Colors.indigo),
    );
  }

  static ThemeData ios() {
    return CustomTheme.android();
  }
}
