import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todotimer/bloc/dailytask_bloc/dailytask_bloc.dart';
import 'package:todotimer/bloc/taskbloc/tasks_bloc.dart';
import 'package:todotimer/models/task.dart';
import 'package:todotimer/models/task_daily.dart';
import 'package:todotimer/views/progress_bar.dart';

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
          // return Center(
          //   child: Text('Loading...'),
          // );
        } else if (state is DailyTaskInitial) {
          _dailyTask = state.dailyTask;
          _secondsLeft = _dailyTask.getSecondsLeftForTheDay();
        } else if (state is CountDownState) {
          _dailyTask = state.dailyTask;
          _secondsLeft = state.leftSeconds;
        } else if (state is CountDownStopped) {
          _dailyTask = state.dailyTask;
          _secondsLeft = state.timeLeft;
          _toggleCountDown = true;
        }

        int _maxSeconds = _dailyTask?.task?.maxSeconds ?? 0;
        double _percentage = (_secondsLeft ?? 0) / _maxSeconds;

        TextStyle _textStyle = Theme.of(context).textTheme.bodyText1!;
        TextStyle _textStyle2 = Theme.of(context).textTheme.bodyText2!;

        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.18,
          direction: Axis.horizontal,
          child: Card(
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(
              top: 12,
              left: 20,
              right: 20,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _dailyTask?.task?.title ?? "...",
                        style: _textStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Row(
                        children: [
                          Text(
                            "Time left:",
                            style: _textStyle2,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8,
                            ),
                          ),
                          Text(
                            _secondsLeft?.toString() ??
                                _dailyTask?.task?.maxSeconds?.toString() ??
                                "...",
                            style: _textStyle2,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                      ),
                      ProgressBar((_dailyTask?.task?.maxSeconds == null
                          ? 0
                          : _percentage)),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(.8),
                              ),
                              child: Icon(
                                _toggleCountDown
                                    ? Icons.play_arrow_rounded
                                    : Icons.pause,
                                color: Colors.white70,
                                size: 32,
                              ),
                            ),
                            onTap: () {
                              final _bloc =
                                  BlocProvider.of<DailyTaskBloc>(context);
                              if (_toggleCountDown) {
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
                              _toggleCountDown = ((_secondsLeft ?? 0) <= 0)
                                  ? true
                                  : !_toggleCountDown;
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          actions: [
            InkWell(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Icon(
                  Icons.delete,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                BlocProvider.of<TasksBloc>(context)
                    .add(DeleteTask(_dailyTask?.task ?? Task()));
                print('deleted');
              },
            ),
          ],
        );
      },
    );
  }
}
