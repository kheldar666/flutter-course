import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/models/task.dart';

class TasksDataProvider extends ChangeNotifier {
  List<Task> tasks = [
    Task(name: 'Task 1'),
    Task(name: 'Task 2'),
    Task(name: 'Task 3'),
  ];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void toggleTask(int index) {
    tasks[index].toggleDone();
    notifyListeners();
  }
}
