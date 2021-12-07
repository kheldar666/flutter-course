import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/models/task.dart';

class TasksDataProvider extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void toggleTask(int index) {
    tasks[index].toggleDone();
    notifyListeners();
  }

  int get tasksCount {
    return tasks.length;
  }

  Task getTask(int index) {
    return tasks[index];
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }
}
