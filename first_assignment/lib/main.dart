import 'package:first_assignment/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const List<String> _texts = [
    'Text 1',
    'Text 2',
    'Text 3',
  ];

  int _textIndex = 0;

  void _swapText() {
    setState(() {
      _textIndex++;
      if (_textIndex > _texts.length - 1) {
        _textIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return App(_texts, _textIndex, _swapText);
  }
}
