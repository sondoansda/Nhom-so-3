import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTaskScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onTaskAdded;

  AddTaskScreen({required this.onTaskAdded});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _note = '';

  // Hàm để thêm công việc mới
  Future<void> addTask() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': _title,
        'completed': false,
        'note': _note, // Thêm ghi chú vào body của công việc mới
      }),
    );

    if (response.statusCode == 201) {
      final newTask = jsonDecode(response.body);
      newTask['note'] = _note; // Lưu ghi chú (note) trong công việc
      widget.onTaskAdded(newTask);  // Thêm công việc vào danh sách Pending Tasks
      Navigator.pop(context);
    } else {
      throw Exception('Failed to add task');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Trường nhập tiêu đề công việc
              TextFormField(
                decoration: InputDecoration(labelText: 'Task Title'),
                onSaved: (value) {
                  _title = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Trường nhập ghi chú (note) cho công việc
              TextFormField(
                decoration: InputDecoration(labelText: 'Task Note (optional)'),
                onSaved: (value) {
                  _note = value ?? ''; // Lưu ghi chú (note) nếu có, ngược lại để trống
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    addTask();
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
