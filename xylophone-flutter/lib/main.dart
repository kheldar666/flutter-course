import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  final player = AudioCache(prefix: 'assets/');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: TextButton(
              onPressed: playSound(),
              child: Text('Click Me'),
            ),
          ),
        ),
      ),
    );
  }

  playSound() {
    player.play('note1.wav');
  }
}
