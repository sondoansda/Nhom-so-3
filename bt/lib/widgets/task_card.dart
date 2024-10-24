import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Map task;
  final Function(int, bool) onTaskUpdate;
  final Function(int) onTaskDelete;
  final Function(int, String) onTaskEdit;

  TaskCard({
    required this.task,
    required this.onTaskUpdate,
    required this.onTaskDelete,
    required this.onTaskEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: task['completed'] ? Colors.grey[200] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: task['completed'],
                onChanged: (bool? value) {
                  onTaskUpdate(task['id'], value!);
                },
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTaskEdit(task['id'], task['title']);
                  },
                  child: Text(
                    task['title'],
                    style: TextStyle(
                      decoration: task['completed'] ? TextDecoration.lineThrough : null,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  onTaskDelete(task['id']);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
