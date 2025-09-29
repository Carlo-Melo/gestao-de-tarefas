import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final Box _box = Hive.box('tasksBox');

  List<Task> get tasks {
    return _box.values.map((t) {
      final map = t as Map;
      return Task(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        dateTime: DateTime.parse(map['dateTime']),
        priority: map['priority'],
        category: map['category'],
        subtasks: (map['subtasks'] as List).map((s) => Task(
          id: s['id'],
          title: s['title'],
          description: s['description'],
          dateTime: DateTime.parse(s['dateTime']),
          priority: s['priority'],
          category: s['category'],
        )).toList(),
      );
    }).toList();
  }

  void addTask(Task task) {
    _box.put(task.id, {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'dateTime': task.dateTime.toIso8601String(),
      'priority': task.priority,
      'category': task.category,
      'subtasks': task.subtasks.map((s) => {
        'id': s.id,
        'title': s.title,
        'description': s.description,
        'dateTime': s.dateTime.toIso8601String(),
        'priority': s.priority,
        'category': s.category,
      }).toList(),
    });
    notifyListeners();
  }

  void updateTask(Task task) {
    addTask(task);
  }

  void deleteTask(String id) {
    _box.delete(id);
    notifyListeners();
  }
}
