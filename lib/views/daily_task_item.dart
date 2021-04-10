import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotimer/bloc/dailytask_bloc/dailytask_bloc.dart';
import 'package:todotimer/bloc/taskbloc/tasks_bloc.dart';
import 'package:todotimer/models/task.dart';

class DailyTaskItem extends StatefulWidget {
  DailyTaskItem();

  @override
  _DailyTaskItemState createState() => _DailyTaskItemState();
}

class _DailyTaskItemState extends State<DailyTaskItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyTaskBloc, DailyTaskState>(
      builder: (ctx, state) {
        if (state is DailyTaskInitial) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(state.dailyTask.task?.title ?? ""),
              Text(state.dailyTask.elapsedSeconds?.toString() ?? ""),
              Column(
                children: [
                  ElevatedButton(
                    child: Container(
                      child: Text('S'),
                    ),
                    onPressed: () {
                      print(
                          "max seconds: ${state.dailyTask.task?.maxSeconds.toString()}");
                    },
                  ),
                  ElevatedButton(
                    child: Text('D'),
                    onPressed: () {
                      BlocProvider.of<TasksBloc>(context)
                          .add(DeleteTask(state.dailyTask.task ?? Task()));
                      print('deleted');
                    },
                  )
                ],
              ),
            ],
          );
        } else {
          return Container(child: Text('could not initialize'));
        }
      },
    );
  }
}
