import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTitle extends StatefulWidget {
  Function loadTasks;

  DateTitle(this.loadTasks, {super.key});

  @override
  State<DateTitle> createState() => _DateTitleState();
}

class _DateTitleState extends State<DateTitle> {
  DateTime _date = DateTime.now();

  void _selectDate() {
    showDatePicker(
            context: context,
            initialDate: _date,
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime(DateTime.now().year + 1))
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    _date = value;
                    widget.loadTasks(_date);
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Morning Routine'),
          Text(
            DateFormat.yMMMd().format(_date),
            style: const TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
