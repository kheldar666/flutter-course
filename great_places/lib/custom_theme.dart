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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.amber,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          elevation: 0,
          padding: const EdgeInsets.all(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
            labelStyle: const TextStyle(color: Colors.indigo),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.indigo,
                width: 2,
              ),
            ),
          ),
    );
  }

  static ThemeData ios() {
    return CustomTheme.android();
  }
}
