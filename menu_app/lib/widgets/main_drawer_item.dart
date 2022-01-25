import 'package:flutter/material.dart';

class MainDrawerItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onTap;
  const MainDrawerItem(
      {required this.label,
      required this.iconData,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
