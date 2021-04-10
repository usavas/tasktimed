import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotimer/bloc/dailytask_bloc/dailytask_bloc.dart';
import 'package:todotimer/models/task_daily.dart';

class DailyTaskItem extends StatefulWidget {
  DailyTaskItem();
  // DailyTaskItem(this.dailyTask);

  // final TaskDaily dailyTask;

  @override
  _DailyTaskItemState createState() => _DailyTaskItemState();
}

class _DailyTaskItemState extends State<DailyTaskItem> {
  @override
  Widget build(BuildContext context) {
    // wrap with bloc
    return BlocBuilder<DailyTaskBloc, DailyTaskState>(
      builder: (ctx, state) {
        if (state is DailyTaskInitial) {
          return ListTile(
            title: Text(state.dailyTask.task?.title ?? ""),
            subtitle: Text(state.dailyTask.elapsedSeconds?.toString() ?? ""),
            trailing: ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Text('X'),
              ),
              onPressed: () {},
            ),
          );
        } else {
          return Container(child: Text('could not initialize'));
        }
      },
    );
  }
}
