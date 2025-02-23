import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "To-Do List",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: taskProvider.tasks.isEmpty
            ? const Center(
                child: Text(
                  "No tasks added yet!",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return TaskTile(task: task);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
        onPressed: () => _showAddTaskBottomSheet(context),
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20,
          top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add New Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Task Title",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.trim().isEmpty ? "Title cannot be empty" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: "Task Description",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel", style: TextStyle(color: Colors.red)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        taskProvider.addTask(
                          titleController.text.trim(),
                          descController.text.trim().isEmpty ? null : descController.text.trim(),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
