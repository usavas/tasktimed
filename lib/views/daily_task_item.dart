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
    return Container(
      child: ListTile(
        title: Text(widget.dailyTask.task?.title ?? ""),
        subtitle: Text(widget.dailyTask.elapsedSeconds?.toString() ?? ""),
      ),
    );
  }
}
