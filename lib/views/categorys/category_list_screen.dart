import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/category_provider.dart';
import '../../models/category.dart';
import 'category_form_screen.dart';

class CategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text("Categorias")),
      body: ListView.builder(
        itemCount: categoryProvider.categories.length,
        itemBuilder: (context, index) {
          Category cat = categoryProvider.categories[index];
          return ListTile(
            leading: Icon(cat.icon, color: cat.color),
            title: Text(cat.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CategoryFormScreen(category: cat)),
                    );
                    if (updated != null) categoryProvider.updateCategory(updated);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => categoryProvider.deleteCategory(cat.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCat = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CategoryFormScreen()),
          );
          if (newCat != null) categoryProvider.addCategory(newCat);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
