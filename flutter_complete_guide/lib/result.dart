import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _score;

  final VoidCallback _callback;

  Result(this._score, this._callback);

  String get resultText {
    var resultPhrase = 'You did it !';

    if (_score <= 8) {
      resultPhrase = 'You are awesome and innocent';
    } else if (_score <= 12) {
      resultPhrase = 'You are pretty likable';
    } else if (_score <= 18) {
      resultPhrase = 'You are ... strange';
    } else {
      resultPhrase = 'You are so bad';
    }

    return resultPhrase;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultText,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            child: Text('Restart Quiz'),
            onPressed: _callback,
            style: OutlinedButton.styleFrom(
              primary: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
