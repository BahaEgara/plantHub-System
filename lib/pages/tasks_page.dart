import 'package:flutter/material.dart';
import '../widgets/task_tile.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      ('Watering', 'Start pump for 15 min', false),
      ('Fertilizer', 'Apply 50kg DAP', true),
      ('Pest Inspection', 'Check leaves for MLN', false),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks & Scheduler')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (var t in tasks)
            TaskTile(title: t.$1, subtitle: t.$2, done: t.$3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
