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
          sliderTheme: SliderTheme.of(context).copyWith(
            thumbColor: Color(0xffeb1555),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
            overlayColor: Color(0x29eb1555),
            inactiveTrackColor: Color(0xff8d8e98),
            activeTrackColor: Colors.white,
          )),
    );
  }
}
