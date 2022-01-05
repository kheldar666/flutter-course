import 'package:first_assignment/my_text.dart';
import 'package:first_assignment/text_control.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final List<String> _texts;
  final int _index;
  final VoidCallback _callback;

  const App(this._texts, this._index, this._callback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Assignment',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('First Assignment'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(_texts[_index]),
              TextControl(_callback),
            ],
          ),
        ),
      ),
    );
  }
}
