import 'dart:async';

import 'package:todotimer/models/task.dart';
import 'package:todotimer/models/task_daily.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todotimer/services/daily_task_service.dart';
import 'package:todotimer/services/task_service.dart';
import 'package:todotimer/services/timer_service.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial());

  @override
  Stream<TasksState> mapEventToState(
    TasksEvent event,
  ) async* {
    if (event is InitializeDailyTasksBasedOnTasks) {
      var dailyTasks = DailyTaskService.getInstance()?.getTasksDaily();
      if (dailyTasks != null) {
        yield TasksChanged(dailyTasks);
      }
    } else if (event is AddNewTask) {
      TaskService.getInstance()?.add(event.task);
      DailyTaskService.getInstance()
          ?.add(TaskDaily(task: event.task, elapsedSeconds: 0));
      var tasksDaily = DailyTaskService.getInstance()?.getTasksDaily();
      if (tasksDaily != null) {
        yield TasksChanged(tasksDaily);
      }
    } else if (event is DeleteTask) {
      TaskService.getInstance()?.delete(event.task);
      DailyTaskService.getInstance()?.delete(TaskDaily(task: event.task));
      var tasksDaily = DailyTaskService.getInstance()?.getTasksDaily();
      if (tasksDaily != null) {
        yield TasksChanged(tasksDaily);
      }
    } else if (event is UpdateTask) {
      TaskService.getInstance()?.update(event.task);
      DailyTaskService.getInstance()?.update(TaskDaily(task: event.task));
      var tasksDaily = DailyTaskService.getInstance()?.getTasksDaily();
      if (tasksDaily != null) {
        yield TasksChanged(tasksDaily);
      }
    }
  }
}
