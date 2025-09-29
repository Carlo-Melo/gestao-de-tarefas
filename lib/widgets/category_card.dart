import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  CategoryCard({required this.category, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: Icon(category.icon, color: category.color),
        title: Text(category.name),
        trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
        onTap: onTap,
      ),
    );
  }
}
