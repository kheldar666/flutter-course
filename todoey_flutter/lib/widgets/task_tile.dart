import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({Key? key}) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;
  void onChange(bool? newValue) {
    setState(() {
      isChecked = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Task 0',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            decoration: isChecked ? TextDecoration.lineThrough : null,
          )),
      trailing: TaskCheckbox(
        checkboxState: isChecked,
        onChange: onChange,
      ),
    );
  }
}

class TaskCheckbox extends StatelessWidget {
  final bool checkboxState;

  final Function onChange;

  const TaskCheckbox(
      {Key? key, required this.checkboxState, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.lightBlueAccent,
      value: checkboxState,
      onChanged: (newValue) => onChange(newValue),
    );
  }
}
