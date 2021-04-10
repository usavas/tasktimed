part of 'dailytasks_bloc.dart';

@immutable
abstract class DailytasksState {}

class DailytasksInitial extends DailytasksState {}

class DailyTasksChanged extends DailytasksState {
  final List<TaskDaily> tasksDaily;
  DailyTasksChanged(this.tasksDaily);
}
