part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksChanged extends TasksState {
  final List<TaskDaily> tasksDaily;
  TasksChanged(this.tasksDaily);
}
