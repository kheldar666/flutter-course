import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  final Function(bool? value) onChanged;

  final Function() onLongPress;

  const TaskTile(
      {Key? key,
      required this.task,
      required this.onChanged,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          )),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: task.isDone,
        onChanged: onChanged,
      ),
      onLongPress: onLongPress,
    );
  }
}
