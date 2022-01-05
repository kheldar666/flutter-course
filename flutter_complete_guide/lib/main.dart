import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/question.dart';
import 'package:flutter_complete_guide/quiz.dart';
import 'package:flutter_complete_guide/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _questions = [
    {
      'questionText': 'What\'s your favorite color ?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal ?',
      'answers': [
        {'text': 'Cat', 'score': 1},
        {'text': 'Rabbit', 'score': 5},
        {'text': 'Dog', 'score': 3},
        {'text': 'Lion', 'score': 10},
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor ?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
      ],
    }
  ];
  var _indexQuestion = 0;
  var _displayQuestions = true;
  int _score = 0;

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      if (_indexQuestion < _questions.length - 1) {
        _indexQuestion++;
      } else {
        _displayQuestions = false;
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _indexQuestion = 0;
      _displayQuestions = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _displayQuestions
            ? Quiz(
                questions: _questions,
                callback: _answerQuestion,
                index: _indexQuestion,
              )
            : Result(_score, _resetQuiz),
      ),
    );
  }
}
