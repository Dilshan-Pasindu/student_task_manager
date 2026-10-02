import 'package:flutter/material.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Task Manager',
      home: const TaskHomePage(),
    );
  }
}

final TextEditingController _taskController = TextEditingController();

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final List<String> _tasks = [];

  void _addTask() {
    final String taskName = _taskController.text.trim();

    if (taskName.isEmpty) {
      return; // ignore empty input
    }

    setState(() {
      _tasks.add(taskName); // change the state
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Task added successfully!')));

    _taskController.clear(); // reset the field
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index); // remove by position
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Task Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Task name',
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add Task'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text('No tasks available'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.task_alt),
                            title: Text(_tasks[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
