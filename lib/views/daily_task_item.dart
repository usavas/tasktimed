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

        if (state is DailyTaskLoading) {
          return Center(
            child: Text('Loading...'),
          );
        } else if (state is DailyTaskInitial) {
          _dailyTask = state.dailyTask;
          _secondsLeft = _dailyTask.getSecondsLeftForTheDay();
        } else if (state is CountDownState) {
          _dailyTask = state.dailyTask;
          _secondsLeft = state.leftSeconds;
          print('seconds left: ${_secondsLeft.toString()}');
        } else if (state is CountDownStopped) {
          _dailyTask = state.dailyTask;
          _secondsLeft = state.timeLeft;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_dailyTask?.task?.title ?? ""),
            Column(
              children: [
                Text(
                  "Time left:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _secondsLeft?.toString() ??
                      _dailyTask?.task?.maxSeconds?.toString() ??
                      "",
                ),
              ],
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
