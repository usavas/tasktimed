import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todotimer/models/task_daily.dart';
import 'package:todotimer/services/daily_task_service.dart';

part 'dailytask_event.dart';
part 'dailytask_state.dart';

class DailyTaskBloc extends Bloc<DailyTaskEvent, DailyTaskState> {
  DailyTaskBloc() : super(DailyTaskLoading());

  late Timer _timer;

  @override
  Stream<DailyTaskState> mapEventToState(
    DailyTaskEvent event,
  ) async* {
    yield DailyTaskLoading();

    if (event is InitDailyTaskValues) {
      yield DailyTaskInitial(event.dailyTask);
    } else if (event is StartCountDown) {
      int maxSeconds = event.dailyTask.task?.maxSeconds ?? 0;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_timer.tick >= maxSeconds) {
          // todo fire the alarm here
          add(StopCountDown(event.dailyTask, _timer.tick));
        } else {
          add(CountDown(event.dailyTask));
        }
      });
    } else if (event is CountDown) {
      event.dailyTask.elapsedSeconds = event.dailyTask.elapsedSeconds! - 1;
      yield (CountDownState(event.dailyTask, _timer.tick));
    } else if (event is StopCountDown) {
      // update the db with the new elapsed time
      int _leftSeconds = (event.taskDaily.task!.maxSeconds! -
              event.taskDaily.elapsedSeconds!) -
          _timer.tick;
      print("left seconds: ${_leftSeconds.toString()}");
      _timer.cancel();
      TaskDaily dailyTaskToUpdate =
          event.taskDaily.copyWith(elapsedSeconds: _leftSeconds);
      await DailyTaskService.getInstance()?.update(dailyTaskToUpdate);
      yield CountDownStopped(event.taskDaily, _leftSeconds);
    }
  }

  int getElapsedTime() {
    return _timer.tick;
  }

  int getTimeLeft(int totalTime) {
    return totalTime - _timer.tick;
  }
}
