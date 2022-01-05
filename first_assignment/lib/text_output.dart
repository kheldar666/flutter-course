import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String _dspText;

  const TextOutput(this._dspText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(_dspText);
  }
}
