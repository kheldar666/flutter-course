import 'package:flutter/material.dart';

class TaskTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Task 0',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          )),
      trailing: Checkbox(
        value: false,
        onChanged: (bool? value) {},
      ),
    );
  }
}
