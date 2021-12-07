import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/tasks_provider.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TasksDataProvider _dataProvider = Provider.of<TasksDataProvider>(context);

    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
          task: _dataProvider.tasks[index],
          callback: (bool? value) {
            _dataProvider.toggleTask(index);
          },
        );
      },
      itemCount: _dataProvider.tasks.length,
    );
  }
}
