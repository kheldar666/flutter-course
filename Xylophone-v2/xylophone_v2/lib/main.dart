import 'dart:math';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final player = AudioCache();

  void playNote(int noteNumber) {
    player.play('note$noteNumber.wav');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  playNote(1);
                },
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  playNote(2);
                },
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: Container(
                    color: Colors.orange,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  playNote(3);
                },
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: Container(
                    color: Colors.yellow,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  playNote(4);
                },
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: Container(
                    color: Colors.green,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  playNote(5);
                },
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: Container(
                    color: Colors.teal,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  playNote(6);
                },
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  playNote(7);
                },
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: Container(
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
