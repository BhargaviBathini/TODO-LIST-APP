import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  final Uuid _uuid = Uuid();

  List<Task> get tasks => _tasks;

  void addTask(String title, String? description) {
    final newTask = Task(
      id: _uuid.v4(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
