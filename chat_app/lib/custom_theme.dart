import 'package:flutter/material.dart';

class CustomTheme {
  static get android => ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink,
        backgroundColor: Colors.pink,
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              backgroundColor: Colors.pink,
            ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(color: Colors.white),
            ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.grey,
          selectionColor: Colors.blueGrey,
          selectionHandleColor: Colors.blueGrey,
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.pink,
            onPrimary: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.pink,
          ),
        ),
        iconTheme: ThemeData.light().iconTheme.copyWith(color: Colors.pink),
        inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
              labelStyle: const TextStyle(color: Colors.grey),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
      );

  static get ios => android;
}
