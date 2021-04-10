import 'dart:async';

import 'package:todotimer/models/task.dart';
import 'package:todotimer/models/task_daily.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todotimer/services/daily_task_service.dart';
import 'package:todotimer/services/task_service.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial());

  @override
  Stream<TasksState> mapEventToState(
    TasksEvent event,
  ) async* {
    if (event is InitializeDailyTasksBasedOnTasks) {
      var dailyTasks = await DailyTaskService.getInstance()?.getTasksDaily();
      if (dailyTasks != null) {
        yield TasksChanged(dailyTasks);
      }
    } else if (event is AddNewTask) {
      await TaskService.getInstance()?.add(event.task);
      await DailyTaskService.getInstance()
          ?.add(TaskDaily(task: event.task, elapsedSeconds: 0));
      var tasksDaily = await DailyTaskService.getInstance()?.getTasksDaily();
      if (tasksDaily != null) {
        yield TasksChanged(tasksDaily);
      }
    } else if (event is DeleteTask) {
      await TaskService.getInstance()?.delete(event.task);
      await DailyTaskService.getInstance()?.delete(TaskDaily(task: event.task));
      var tasksDaily = await DailyTaskService.getInstance()?.getTasksDaily();
      if (tasksDaily != null) {
        yield TasksChanged(tasksDaily);
      }
    } else if (event is UpdateTask) {
      await TaskService.getInstance()?.update(event.task);
      await DailyTaskService.getInstance()?.update(TaskDaily(task: event.task));
      var tasksDaily = await DailyTaskService.getInstance()?.getTasksDaily();
      if (tasksDaily != null) {
        yield TasksChanged(tasksDaily);
      }
    }
  }
}
