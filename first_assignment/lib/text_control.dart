import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final VoidCallback _callback;

  const TextControl(this._callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _callback,
      child: const Text('Swap text'),
    );
  }
}
