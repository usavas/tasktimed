import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todotimer/models/task_daily.dart';
import 'package:todotimer/services/daily_task_service.dart';

part 'dailytask_event.dart';
part 'dailytask_state.dart';

class DailyTaskBloc extends Bloc<DailyTaskEvent, DailyTaskState> {
  DailyTaskBloc() : super(DailyTaskDefault());

  @override
  Stream<DailyTaskState> mapEventToState(
    DailyTaskEvent event,
  ) async* {
    if (event is InitDailyTaskValues) {
      yield DailyTaskInitial(event.dailyTask);
    }
    if (event is StartCountDown) {
      yield DailyTaskCountDownStarted(event.secondsLeft);

      // var timer = TimerService(event.secondsLeft);
      // var stream = timer.startTimer();
      // stream.listen((currSeconds) {
      //   yield DailyTaskCountDown()
      // });
    } else if (event is StopCountDown) {
      DailyTaskService.getInstance()
          ?.update(event.taskDaily..elapsedSeconds = event.countdownValue);
      yield CountDownStopped(event.countdownValue);
    }
  }
}
