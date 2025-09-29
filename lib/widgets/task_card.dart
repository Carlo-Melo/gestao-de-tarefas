import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  TaskCard({required this.task, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text("${task.category} - Prioridade: ${task.priority}"),
        trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
        onTap: onTap,
      ),
    );
  }
}
