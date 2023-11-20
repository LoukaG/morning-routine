import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:morning_routine/src/screens/routine.dart';
import 'package:morning_routine/src/widgets/task_list/date_title.dart';

// ignore: must_be_immutable
class MainAppbar extends StatelessWidget implements PreferredSizeWidget{
  final Function _loadTasks;

  const MainAppbar(this._loadTasks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: DateTitle(_loadTasks),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Routine()),
              );
            },
            icon: const Icon(Icons.sunny))
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
