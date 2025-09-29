import 'package:flutter/material.dart';
import '../../models/category.dart';
import 'package:uuid/uuid.dart';

class CategoryFormScreen extends StatefulWidget {
  final Category? category;
  CategoryFormScreen({this.category});

  @override
  _CategoryFormScreenState createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Color _color = Colors.blue;
  IconData _icon = Icons.category;

  final List<IconData> _icons = [Icons.work, Icons.school, Icons.home, Icons.fitness_center, Icons.shopping_cart];

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _color = widget.category!.color;
      _icon = widget.category!.icon;
    }
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      Category newCategory = Category(
        id: widget.category?.id ?? Uuid().v4(),
        name: _nameController.text,
        color: _color,
        icon: _icon,
      );
      Navigator.pop(context, newCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text(widget.category == null ? "Nova Categoria" : "Editar Categoria")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nome da Categoria"),
                validator: (v) => v!.isEmpty ? "Preencha o nome" : null,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Cor: "),
                  GestureDetector(
                    onTap: () async {
                      Color? picked = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Escolher cor"),
                          content: Wrap(
                            children: [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple]
                                .map((c) => GestureDetector(
                                      onTap: () => Navigator.pop(context, c),
                                      child: Container(width: 30, height: 30, color: c, margin: EdgeInsets.all(5)),
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                      if (picked != null) setState(() => _color = picked);
                    },
                    child: Container(width: 30, height: 30, color: _color),
                  ),
                ],
              ),
              SizedBox(height: 10),
              DropdownButton<IconData>(
                value: _icon,
                items: _icons.map((e) => DropdownMenuItem(value: e, child: Icon(e))).toList(),
                onChanged: (v) => setState(() => _icon = v!),
                hint: Text("Escolher ícone"),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveCategory, child: Text("Salvar Categoria")),
            ],
          ),
        ),
      ),
    );
  }
}
