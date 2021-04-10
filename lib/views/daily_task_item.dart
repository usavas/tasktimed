import 'package:flutter/material.dart';
import 'package:todotimer/models/task_daily.dart';

class DailyTaskItem extends StatefulWidget {
  DailyTaskItem(this.dailyTask);

  final TaskDaily dailyTask;

  @override
  _DailyTaskItemState createState() => _DailyTaskItemState();
}

class _DailyTaskItemState extends State<DailyTaskItem> {
  @override
  Widget build(BuildContext context) {
    // wrap with bloc
    return ListTile(
      title: Text(widget.dailyTask.task?.title ?? ""),
      subtitle: Text(widget.dailyTask.elapsedSeconds?.toString() ?? ""),
      trailing: ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Text('X'),
        ),
        onPressed: () {},
      ),
    );
  }
}
