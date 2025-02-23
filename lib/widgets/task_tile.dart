import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: task.description != null ? Text(task.description!) : null,
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => taskProvider.toggleTaskStatus(task.id),
        ),
        onLongPress: () => taskProvider.removeTask(task.id),
      ),
    );
  }
}
