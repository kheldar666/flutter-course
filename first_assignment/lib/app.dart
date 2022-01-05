import 'package:first_assignment/text_control.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Assignment',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('First Assignment'),
        ),
        body: const TextControl(),
      ),
    );
  }
}
