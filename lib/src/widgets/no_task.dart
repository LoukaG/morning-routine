import 'package:flutter/material.dart';

class NoTask extends StatelessWidget {
  const NoTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/img/sleep.png", width: MediaQuery.of(context).size.width*0.9, height: MediaQuery.of(context).size.height*0.4),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'No tasks yet',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Tap the + button to add a new task',
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
