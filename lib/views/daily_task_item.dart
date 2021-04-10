import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotimer/bloc/dailytask_bloc/dailytask_bloc.dart';
import 'package:todotimer/bloc/taskbloc/tasks_bloc.dart';
import 'package:todotimer/models/task.dart';
import 'package:todotimer/models/task_daily.dart';

class DailyTaskItem extends StatefulWidget {
  DailyTaskItem();

  @override
  _DailyTaskItemState createState() => _DailyTaskItemState();
}

class _DailyTaskItemState extends State<DailyTaskItem> {
  bool _toggleCountDown = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyTaskBloc, DailyTaskState>(
      builder: (ctx, state) {
        TaskDaily? _dailyTask;
        int? _secondsLeft;

        if (state is DailyTaskDefault) {
          return Center(
            child: Text('Loading...'),
          );
        }
        if (state is DailyTaskInitial) {
          _dailyTask = state.dailyTask;
        } else if (state is CountDownState) {
          print('countdown state is called');
          _dailyTask = state.dailyTask;
          int _maxSeconds = _dailyTask.task?.maxSeconds ?? 0;
          _secondsLeft = _maxSeconds - state.timerTickValue;
          print('seconds left: ${_secondsLeft.toString()}');
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_dailyTask?.task?.title ?? ""),
            Text(
              _secondsLeft?.toString() ??
                  _dailyTask?.task?.maxSeconds?.toString() ??
                  "",
            ),
            Column(
              children: [
                ElevatedButton(
                  child: Container(
                    child: Text('S'),
                  ),
                  onPressed: () {
                    final _bloc = BlocProvider.of<DailyTaskBloc>(context);

                    if (_toggleCountDown) {
                      // start the timer
                      _bloc.add(StartCountDown(
                        _dailyTask ?? TaskDaily(),
                        _dailyTask?.elapsedSeconds ?? 0,
                      ));
                    } else {
                      _bloc.add(
                        StopCountDown(
                          _dailyTask ?? TaskDaily(),
                          _secondsLeft ?? 0,
                        ),
                      );
                    }
                    _toggleCountDown = !_toggleCountDown;
                  },
                ),
                ElevatedButton(
                  child: Text('D'),
                  onPressed: () {
                    BlocProvider.of<TasksBloc>(context)
                        .add(DeleteTask(_dailyTask?.task ?? Task()));
                    print('deleted');
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
