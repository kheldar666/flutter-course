import 'package:flutter/material.dart';
import 'package:menu_app/widgets/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const String routeName = '/filters';
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        drawer: const MainDrawer(),
        body: Center(
          child: Text('Filters !'),
        ),
      ),
    );
  }
}
