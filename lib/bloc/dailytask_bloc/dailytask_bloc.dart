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
      yield DailyTaskInitial(event.dailyTask);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        int _secondsLeft = event.dailyTask.getSecondsLeftForTheDay();
        //
        print("timer.tick: ${timer.tick.toString()}");
        print("Seconds left: $_secondsLeft");
        if (_secondsLeft <= 0) {
          add(StopCountDown(event.dailyTask, _secondsLeft));
        } else {
          event.dailyTask.elapsedSeconds = event.dailyTask.elapsedSeconds! + 1;
          add(CountDown(event.dailyTask, _secondsLeft - 1));
        }
      });
    } else if (event is CountDown) {
      yield CountDownState(event.dailyTask, event.elapsedSeconds);
    } else if (event is StopCountDown) {
      _timer.cancel();
      await DailyTaskService.getInstance()?.update(event.taskDaily);
      yield CountDownStopped(event.taskDaily, event.secondsLeft);
    }
  }
}
