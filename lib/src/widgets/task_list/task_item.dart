import 'package:flutter/material.dart';
import 'package:morning_routine/src/models/task.dart';

class TaskItem extends StatelessWidget {
  Task task;
  Function deleteTask;
  Function toggleTask;

  TaskItem(
      {required Key key,
      required this.task,
      required this.deleteTask,
      required this.toggleTask}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        key: key,
        leading: Checkbox(
          value: task.isDone,
          onChanged: (value) {
            toggleTask(task);
          },
        ),
        title: Row(
          children: [
            Icon(task.icon),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              task.name,
              style: TextStyle(
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
        trailing: IconButton(
            onPressed: () {
              deleteTask(task);
            },
            icon: const Icon(Icons.delete)));
  }
}
