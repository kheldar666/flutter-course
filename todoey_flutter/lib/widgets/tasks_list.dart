import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/tasks_provider.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksDataProvider>(
      builder: (context, tasksData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
                task: tasksData.getTask(index),
                onChanged: (bool? value) {
                  tasksData.toggleTask(index);
                },
                onLongPress: () {
                  tasksData.deleteTask(index);
                });
          },
          itemCount: tasksData.tasksCount,
        );
      },
    );
  }
}
