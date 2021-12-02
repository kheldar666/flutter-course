import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/price_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}
