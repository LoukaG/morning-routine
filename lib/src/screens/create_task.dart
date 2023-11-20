import 'package:flutter/material.dart';

import '../models/task.dart';

class CreateTask extends StatefulWidget {
  final Function onSubmit;

  CreateTask({
    super.key,
    required this.onSubmit,
  });

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _controller = TextEditingController();

  IconData? _selectedIcon = Icons.star;

  final List<IconData> _icons = [
    Icons.star,
    Icons.directions_car,
    Icons.egg_alt,
    Icons.menu_book,
    Icons.fitness_center,
    Icons.self_improvement,
    Icons.shower,
    Icons.directions_walk,
    Icons.headphones,
    Icons.mood,
    Icons.coffee,
    Icons.face,
    Icons.bed,
    Icons.sunny,
    Icons.home,
    Icons.alarm,
    Icons.forest,
    Icons.favorite,
    Icons.medication,
    Icons.backpack,
    Icons.list,
    Icons.pets,
    Icons.computer,
    Icons.phone_android
  ];

  void _validate() {
    if (_controller.text.isNotEmpty && _selectedIcon != null) {
      widget.onSubmit(Task(
        name: _controller.text,
        icon: _selectedIcon ?? Icons.star,
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must fill the task name and select an icon'),
          backgroundColor: Colors.redAccent,
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          title: const Text('Create Task'),
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: _icons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final icon = _icons[index];
                      final isSelected = icon == _selectedIcon;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIcon = icon;
                          });
                        },
                        child: Icon(
                          icon,
                          color: isSelected ? Colors.deepPurple : Colors.grey,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _validate,
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
        ));
  }
}
