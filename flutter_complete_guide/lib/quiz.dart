import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/question.dart';

class Quiz extends StatelessWidget {
  final Function callback;

  final List<Map<String, Object>> questions;

  final int index;

  Quiz({
    required this.questions,
    required this.callback,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[index]['questionText'] as String),
        ...(questions[index]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(answer, callback);
        }).toList(),
      ],
    );
  }
}
