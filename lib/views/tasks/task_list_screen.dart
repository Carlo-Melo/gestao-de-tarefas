import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../models/task.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Minhas Tarefas")),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          Task task = taskProvider.tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text("${task.category} - Prioridade: ${task.priority}"),
            onTap: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TaskFormScreen(task: task)),
              );
              if (updated != null) taskProvider.updateTask(updated);
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => taskProvider.deleteTask(task.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskFormScreen()),
          );
          if (newTask != null) taskProvider.addTask(newTask);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
