import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Map<String, Object> answer;

  final Function selectHandler;

  Answer(this.answer, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(answer['text'] as String),
        onPressed: () => selectHandler(answer['score'] as int),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber),
          foregroundColor: MaterialStateProperty.all(Colors.red),
        ),
      ),
    );
  }
}
