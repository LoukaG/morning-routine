import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  final String name;
  int iconCodePoint;
  bool isDone = false;

  Task({
    required this.name,
    required IconData icon, // Prend toujours IconData en paramètre
    this.isDone = false,
  }) : iconCodePoint = icon.codePoint;

  Task.fromCodePoint({
    required this.name,
    required this.iconCodePoint,
    this.isDone = false,
  });

  void toggleDone() {
    isDone = !isDone;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task.fromCodePoint(
        name: json['name'] as String,
        iconCodePoint: json['icon'] as int,
        isDone: bool.parse(json['isDone']));
  }

  //method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isDone': isDone.toString(),
      'icon': icon.codePoint,
    };
  }

  IconData get icon => IconData(
        iconCodePoint,
        fontFamily: 'MaterialIcons',
      );

  static Future<List<Task>> loadTasks(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(name) && name != "routine") {
      return await Task.loadTasks("routine");
    } else {
      List<Task> tasks = [];
      prefs.getStringList(name)?.forEach((element) {
        final task = Task.fromJson(jsonDecode(element));
        tasks.add(task);
      });

      return tasks;
    }
  }

  static void saveTasks(List<Task> tasks, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasksJson = [];
    for (var task in tasks) {
      tasksJson.add(jsonEncode(task.toJson()));
    }
    prefs.setStringList(name, tasksJson);
  }
}
