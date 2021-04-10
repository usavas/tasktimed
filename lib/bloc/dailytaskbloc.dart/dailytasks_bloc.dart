import 'dart:async';

import 'package:todotimer/models/task.dart';
import 'package:todotimer/models/task_daily.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todotimer/services/daily_task_service.dart';
import 'package:todotimer/services/task_service.dart';
import 'package:todotimer/services/timer_service.dart';

part 'dailytasks_event.dart';
part 'dailytasks_state.dart';

class DailytasksBloc extends Bloc<DailytasksEvent, DailytasksState> {
  DailytasksBloc() : super(DailytasksInitial());

  @override
  Stream<DailytasksState> mapEventToState(
    DailytasksEvent event,
  ) async* {
    if (event is AddNewTask) {
      TaskService.getInstance()?.add(event.task);
      DailyTaskService.getInstance()
          ?.add(TaskDaily(task: event.task, elapsedSeconds: 0));
      var tasksDaily = await DailyTaskService.getInstance()?.getTasksDaily();
      yield DailyTasksChanged(tasksDaily ?? []);
    } else if (event is DeleteTask) {
      TaskService.getInstance()?.delete(event.task);
      DailyTaskService.getInstance()?.delete(TaskDaily(task: event.task));
      var tasksDaily = await DailyTaskService.getInstance()?.getTasksDaily();
      yield DailyTasksChanged(tasksDaily ?? []);
    } else if (event is UpdateTask) {
      TaskService.getInstance()?.update(event.task);
      DailyTaskService.getInstance()?.update(TaskDaily(task: event.task));
      var tasksDaily = await DailyTaskService.getInstance()?.getTasksDaily();
      yield DailyTasksChanged(tasksDaily ?? []);
    }

    // else if (event is StartTimerOnDailyTask) {
    //   var timer = TimerService(event.secondsLeft);
    //   var stream = timer.startTimer();
    //   stream.listen((currSeconds) {
    //     yield
    //   });
    // }
  }
}
