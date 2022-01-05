import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String _dspText;

  const MyText(this._dspText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(_dspText);
  }
}
