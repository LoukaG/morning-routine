import 'package:flutter/material.dart';
import 'package:morning_routine/src/models/task.dart';

class RoutineItem extends StatelessWidget {
  Task task;
  Function deleteTask;

  RoutineItem(
      {required Key key,
      required this.task,
      required this.deleteTask,}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        key: key,
        leading: Icon(task.icon),
        title: Text(
          task.name,
          style: TextStyle(
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: IconButton(
            onPressed: () {
              deleteTask(task);
            },
            icon: const Icon(Icons.delete)));
  }
}
