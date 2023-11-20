import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:morning_routine/src/screens/create_task.dart';
import 'package:morning_routine/src/widgets/no_task.dart';
import 'package:morning_routine/src/widgets/task_list/main_appbar.dart';
import 'package:morning_routine/src/widgets/task_list/task_item.dart';

import '../models/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskListState();
  }
}

class _TaskListState extends State<TaskList> {
  List<Task> _tasks = [];
  String _tasksKey = "";

  @override
  void initState() {
    super.initState();
    _updateTasks(DateTime.now());
  }

  void _updateTasks(DateTime date) async {
    _tasksKey = DateFormat.yMd().format(date);
    List<Task> tasks = await Task.loadTasks(_tasksKey);
    setState(() {
      _tasks = tasks;
    });
  }

  void _deleteTask(Task task) {
    Widget cancel = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Annuler"));

    Widget deleteButton = TextButton(
        onPressed: () {
          setState(() {
            _tasks.remove(task);
          });
          Task.saveTasks(_tasks, _tasksKey);
          Navigator.of(context).pop();
        },
        child: const Text("Supprimer"));

    AlertDialog alert = AlertDialog(
      title: const Text("Supprimer ?"),
      content: const Text("Êtes vous sûr de vouloir supprimer cette tâche?"),
      actions: [cancel, deleteButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
      Task.saveTasks(_tasks, _tasksKey);
    });
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
      Task.saveTasks(_tasks, _tasksKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppbar(_updateTasks),
        body: _tasks.isEmpty
            ? const NoTask()
            : ReorderableListView.builder(
                itemBuilder: (ctx, index) {
                  return TaskItem(
                      key: ValueKey(index),
                      task: _tasks[index],
                      deleteTask: _deleteTask,
                      toggleTask: _toggleTask);
                },
                itemCount: _tasks.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Task task = _tasks.removeAt(oldIndex);
                    _tasks.insert(newIndex, task);
                    Task.saveTasks(_tasks, _tasksKey);
                  });
                }),
        floatingActionButton: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateTask(
                        onSubmit: _addTask,
                      )),
            );
          },
          icon: const Icon(Icons.add),
          color: Colors.black,
        ));
  }
}
