import 'package:flutter/material.dart';
import 'package:todotimer/task.dart';

class TaskItem extends StatefulWidget {
  TaskItem(this.task);

  final Task task;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title ?? ''),
      subtitle: Text(
        'min: ${widget.task.minSeconds.toString()}, max: ${widget.task.maxSeconds.toString()}',
      ),
    );
  }
}
