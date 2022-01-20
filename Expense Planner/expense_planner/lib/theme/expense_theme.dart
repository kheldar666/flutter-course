import 'package:flutter/material.dart';

class ExpenseTheme {
  static ThemeData android() {
    return ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        colorScheme:
            ThemeData.light().colorScheme.copyWith(secondary: Colors.amber),
        iconTheme: ThemeData.light().iconTheme.copyWith(color: Colors.black),
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        appBarTheme: const AppBarTheme(
          toolbarTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  static ThemeData ios() {
    return ExpenseTheme.android();
  }
}
