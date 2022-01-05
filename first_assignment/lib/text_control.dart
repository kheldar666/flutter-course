import 'package:first_assignment/text_output.dart';
import 'package:flutter/material.dart';

class TextControl extends StatefulWidget {
  const TextControl({Key? key}) : super(key: key);

  @override
  State<TextControl> createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
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
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextOutput(_texts[_textIndex]),
          ElevatedButton(onPressed: _swapText, child: const Text('Swap text')),
        ],
      ),
    );
  }
}
