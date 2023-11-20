import 'package:flutter/material.dart';
import 'package:morning_routine/src/screens/task_list.dart';

class MorningRoutine extends StatelessWidget{
  const MorningRoutine({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morning Routine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TaskList(),
    );
  }
  
}