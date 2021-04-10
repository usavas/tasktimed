import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todotimer/models/task_daily.dart';
import 'package:todotimer/services/daily_task_service.dart';

part 'dailytask_event.dart';
part 'dailytask_state.dart';

class DailyTaskBloc extends Bloc<DailyTaskEvent, DailyTaskState> {
  DailyTaskBloc() : super(DailyTaskDefault());

  late Timer _timer;

  @override
  Stream<DailyTaskState> mapEventToState(
    DailyTaskEvent event,
  ) async* {
    // yield DailyTaskDefault();

    if (event is InitDailyTaskValues) {
      yield DailyTaskInitial(event.dailyTask);
    } else if (event is StartCountDown) {
      int maxSeconds = event.dailyTask.task?.maxSeconds ?? 0;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_timer.tick >= maxSeconds) {
          add(StopCountDown(event.dailyTask, _timer.tick));
        } else {
          // print(_timer.tick.toString());
          add(CountDown(event.dailyTask));
        }
      });
    } else if (event is CountDown) {
      print(_timer.tick.toString());
      yield (CountDownState(event.dailyTask, _timer.tick));
    } else if (event is StopCountDown) {
      // update the db with the new elapsed time
      int countDownValue = _timer.tick;
      int totalElapsedSeconds = event.taskDaily.elapsedSeconds ??
          event.taskDaily.task?.maxSeconds ??
          0 + countDownValue;
      _timer.cancel();
      DailyTaskService.getInstance()
          ?.update(event.taskDaily..elapsedSeconds = totalElapsedSeconds);
      yield CountDownStopped(event.countdownValue);
    }
  }
}
