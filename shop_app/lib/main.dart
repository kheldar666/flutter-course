import 'package:flutter/material.dart';
import 'package:shop_app/shop_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Shop App',
      theme: ShopTheme.android(),
      home: const MyHomePage('The Shop App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage(this.title, {Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Shop App Home Screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
