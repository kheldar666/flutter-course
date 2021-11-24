import 'package:bmi_calculator/input_dart.dart';
import 'package:flutter/material.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputPage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0a0e21),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF0a0e21),
          secondary: Colors.greenAccent,
        ),
      ),
    );
  }
}
