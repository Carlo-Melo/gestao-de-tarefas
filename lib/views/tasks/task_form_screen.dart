import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../providers/task_provider.dart';
import 'package:uuid/uuid.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task; // Se null, cria nova; senão, edita existente
  TaskFormScreen({this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _priority = 1;
  String _category = 'Nenhuma';
  List<Task> _subtasks = [];

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
      _selectedDate = widget.task!.dateTime;
      _selectedTime = TimeOfDay(hour: _selectedDate.hour, minute: _selectedDate.minute);
      _priority = widget.task!.priority;
      _category = widget.task!.category;
      _subtasks = widget.task!.subtasks;
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(context: context, initialTime: _selectedTime);
    if (time != null) setState(() => _selectedTime = time);
  }

  void _addSubtask() {
    setState(() {
      _subtasks.add(Task(
        id: Uuid().v4(),
        title: 'Nova Subtarefa',
        description: '',
        dateTime: DateTime.now(),
        priority: 1,
        category: _category,
      ));
    });
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      Task newTask = Task(
        id: widget.task?.id ?? Uuid().v4(),
        title: _titleController.text,
        description: _descController.text,
        dateTime: dateTime,
        priority: _priority,
        category: _category,
        subtasks: _subtasks,
      );

      if (widget.task == null) {
        taskProvider.addTask(newTask);
      } else {
        taskProvider.updateTask(newTask);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? "Nova Tarefa" : "Editar Tarefa")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Título"),
                validator: (v) => v!.isEmpty ? "Preencha o título" : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: "Descrição"),
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Data: ${_selectedDate.toLocal()}".split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text("Hora: ${_selectedTime.format(context)}"),
                trailing: Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              DropdownButtonFormField<int>(
                value: _priority,
                items: [1, 2, 3, 4, 5].map((e) => DropdownMenuItem(value: e, child: Text("Prioridade $e"))).toList(),
                onChanged: (v) => setState(() => _priority = v!),
                decoration: InputDecoration(labelText: "Prioridade"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Categoria"),
                initialValue: _category,
                onChanged: (v) => _category = v,
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: _addSubtask, child: Text("Adicionar Subtarefa")),
              ..._subtasks.map((sub) => ListTile(title: Text(sub.title))),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveTask, child: Text("Salvar Tarefa")),
            ],
          ),
        ),
      ),
    );
  }
}
