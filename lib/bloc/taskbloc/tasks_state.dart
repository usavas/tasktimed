part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksChanged extends TasksState {
  final Future<List<TaskDaily>> dailyTasks;
  TasksChanged(this.dailyTasks);
}
