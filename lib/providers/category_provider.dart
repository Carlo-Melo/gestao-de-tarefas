import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  final Box _box = Hive.box('categoriesBox');

  List<Category> get categories {
    return _box.values.map((c) => Category(
      id: c['id'],
      name: c['name'],
      color: Color(c['color']),
      icon: IconData(c['icon'], fontFamily: 'MaterialIcons'),
    )).toList();
  }

  void addCategory(Category category) {
    _box.put(category.id, {
      'id': category.id,
      'name': category.name,
      'color': category.color.value,
      'icon': category.icon.codePoint,
    });
    notifyListeners();
  }

  void updateCategory(Category category) {
    _box.put(category.id, {
      'id': category.id,
      'name': category.name,
      'color': category.color.value,
      'icon': category.icon.codePoint,
    });
    notifyListeners();
  }

  void deleteCategory(String id) {
    _box.delete(id);
    notifyListeners();
  }
}
