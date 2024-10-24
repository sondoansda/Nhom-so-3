import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tasks = [];
  String searchKeyword = ''; // Biến lưu trữ từ khóa tìm kiếm

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  // Hàm lấy danh sách các công việc từ API
  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      setState(() {
        tasks = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Cập nhật trạng thái của công việc (hoàn thành/chưa hoàn thành)
  void updateTask(int id, bool completed) {
    setState(() {
      tasks.firstWhere((task) => task['id'] == id)['completed'] = completed;

      // Di chuyển công việc đã hoàn thành lên đầu danh sách Completed Tasks
      tasks.sort((a, b) {
        if (a['completed'] && !b['completed']) {
          return 1;
        } else if (!a['completed'] && b['completed']) {
          return -1;
        }
        return 0;
      });
    });

    http.patch(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'completed': completed}),
    );
  }

  // Hàm hiển thị popup để sửa công việc
  void editTask(int taskId, String currentTitle, String currentNote) {
    TextEditingController _titleController = TextEditingController(text: currentTitle);
    TextEditingController _noteController = TextEditingController(text: currentNote);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(labelText: 'Task Note (optional)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateTaskTitle(taskId, _titleController.text, _noteController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Cập nhật tiêu đề và ghi chú công việc
  Future<void> _updateTaskTitle(int id, String newTitle, String newNote) async {
    setState(() {
      tasks.firstWhere((task) => task['id'] == id)['title'] = newTitle;
      tasks.firstWhere((task) => task['id'] == id)['note'] = newNote;
    });

    final response = await http.patch(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'title': newTitle, 'note': newNote}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  // Xóa công việc
  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'));
    if (response.statusCode == 200) {
      setState(() {
        tasks.removeWhere((task) => task['id'] == id);
      });
    } else {
      throw Exception('Failed to delete task');
    }
  }

  // Hàm lọc công việc theo từ khóa tìm kiếm
  List filterTasks(List tasks) {
    if (searchKeyword.isEmpty) {
      return tasks;
    }

    return tasks.where((task) {
      final title = task['title'].toLowerCase();
      final note = (task['note'] ?? '').toLowerCase();
      final search = searchKeyword.toLowerCase();
      return title.contains(search) || note.contains(search);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Lọc các công việc chưa hoàn thành
    List pendingTasks = filterTasks(tasks.where((task) => !task['completed']).toList());
    // Lọc các công việc đã hoàn thành
    List completedTasks = filterTasks(tasks.where((task) => task['completed']).toList());

    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo List'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thanh tìm kiếm công việc
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Tasks',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchKeyword = value;
                });
              },
            ),
            SizedBox(height: 15),
            // Container chứa các công việc chưa hoàn thành với viền
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pending Tasks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: pendingTasks.length,
                        itemBuilder: (context, index) {
                          var task = pendingTasks[index];
                          return ListTile(
                            leading: Checkbox(
                              value: task['completed'],
                              onChanged: (bool? value) {
                                updateTask(task['id'], value!);
                              },
                            ),
                            title: GestureDetector(
                              onTap: () {
                                editTask(task['id'], task['title'], task['note'] ?? '');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(task['title']),
                                  if (task['note'] != null && task['note'] != '')
                                    Text(
                                      task['note'],
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                deleteTask(task['id']);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Container chứa các công việc đã hoàn thành với viền
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Completed Tasks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: completedTasks.length,
                        itemBuilder: (context, index) {
                          var task = completedTasks[index];
                          return ListTile(
                            leading: Checkbox(
                              value: task['completed'],
                              onChanged: (bool? value) {
                                updateTask(task['id'], value!);
                              },
                            ),
                            title: GestureDetector(
                              onTap: () {
                                editTask(task['id'], task['title'], task['note'] ?? '');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task['title'],
                                    style: TextStyle(
                                      decoration: task['completed']
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                  if (task['note'] != null && task['note'] != '')
                                    Text(
                                      task['note'],
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                deleteTask(task['id']);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen(onTaskAdded: (newTask) {
              setState(() {
                tasks.insert(0, newTask);
              });
            })),
          );
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
    );
  }
}
