import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final player = AudioCache();

  void playNote(int noteNumber) {
    player.play('note$noteNumber.wav');
  }

  Widget buildKey({required int note, required Color keyColor}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          playNote(note);
        },
        child: Container(
          color: keyColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(note: 1, keyColor: Colors.red),
              buildKey(note: 2, keyColor: Colors.orange),
              buildKey(note: 3, keyColor: Colors.yellow),
              buildKey(note: 4, keyColor: Colors.green),
              buildKey(note: 5, keyColor: Colors.teal),
              buildKey(note: 6, keyColor: Colors.blue),
              buildKey(note: 7, keyColor: Colors.deepPurple),
            ],
          ),
        ),
      ),
    );
  }
}
