part of 'tasks_bloc.dart';

@immutable
abstract class TasksState extends Equatable {
  const TasksState();
}

class TasksInitial extends TasksState {
  const TasksInitial();
  @override
  List<Object?> get props => [];
}

class TasksChanged extends TasksState {
  final List<TaskDaily> dailyTasks;
  const TasksChanged(this.dailyTasks);

  @override
  List<Object?> get props => [dailyTasks];
}
