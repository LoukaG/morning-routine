import 'package:flutter/material.dart';
import 'package:morning_routine/src/screens/create_task.dart';
import 'package:morning_routine/src/widgets/no_task.dart';
import 'package:morning_routine/src/widgets/routine/routine_item.dart';

import '../models/task.dart';

class Routine extends StatefulWidget {
  const Routine({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RoutineState();
  }
}

class _RoutineState extends State<Routine> {
  List<Task> _tasks = [];
  final _tasksKey = "routine";

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          title: const Text('My Routine'),
        ),
        body: _tasks.isEmpty
            ? const NoTask()
            : ReorderableListView.builder(
                itemBuilder: (ctx, index) {
                  return RoutineItem(
                      key: ValueKey(index),
                      task: _tasks[index],
                      deleteTask: _deleteTask);
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
