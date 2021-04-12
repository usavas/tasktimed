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

        TextStyle _textStyle = Theme.of(context).textTheme.bodyText1!;
        // TextStyle _textStyleBold = Theme.of(context)
        //     .textTheme
        //     .bodyText1!
        //     .copyWith(fontWeight: FontWeight.bold);

        return Card(
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _dailyTask!.task!.title ?? "",
                      style: _textStyle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                    ),
                    Row(
                      children: [
                        Text(
                          "Time left:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 8,
                          ),
                        ),
                        Text(
                          _secondsLeft?.toString() ??
                              _dailyTask.task?.maxSeconds?.toString() ??
                              "",
                        ),
                      ],
                    ),
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
                              color:
                                  Theme.of(context).accentColor.withOpacity(.6),
                            ),
                            child: Icon(_toggleCountDown
                                ? Icons.play_arrow_rounded
                                : Icons.pause),
                          ),
                          onTap: () {
                            final _bloc =
                                BlocProvider.of<DailyTaskBloc>(context);
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
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );

        // return Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(_dailyTask?.task?.title ?? ""),
        //     Column(
        //       children: [
        //         Text(
        //           "Time left:",
        //           style: TextStyle(fontWeight: FontWeight.bold),
        //         ),
        //         Text(
        //           _secondsLeft?.toString() ??
        //               _dailyTask?.task?.maxSeconds?.toString() ??
        //               "",
        //         ),
        //       ],
        //     ),
        //     Column(
        //       children: [
        //         ElevatedButton(
        //           child: Container(
        //             child: Text('S'),
        //           ),
        //           onPressed: () {
        //             final _bloc = BlocProvider.of<DailyTaskBloc>(context);

        //             if (_toggleCountDown) {
        //               // start the timer
        //               _bloc.add(StartCountDown(
        //                 _dailyTask ?? TaskDaily(),
        //                 _dailyTask?.elapsedSeconds ?? 0,
        //               ));
        //             } else {
        //               _bloc.add(
        //                 StopCountDown(
        //                   _dailyTask ?? TaskDaily(),
        //                   _secondsLeft ?? 0,
        //                 ),
        //               );
        //             }
        //             _toggleCountDown = !_toggleCountDown;
        //           },
        //         ),
        //         ElevatedButton(
        //           child: Text('D'),
        //           onPressed: () {
        //             BlocProvider.of<TasksBloc>(context)
        //                 .add(DeleteTask(_dailyTask?.task ?? Task()));
        //             print('deleted');
        //           },
        //         )
        //       ],
        //     ),
        //   ],
        // );
      },
    );
  }
}
