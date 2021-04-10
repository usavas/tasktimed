part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {
  TasksState();
}

class TasksInitial extends TasksState {
  TasksInitial();
}

class TasksChanged extends TasksState {
  final List<TaskDaily> dailyTasks;
  TasksChanged(this.dailyTasks);
}
