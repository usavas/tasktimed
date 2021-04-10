part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {
  TasksEvent();
}

class InitializeDailyTasksBasedOnTasks extends TasksEvent {}

class AddNewTask extends TasksEvent {
  AddNewTask(this.task);
  final Task task;
}

class DeleteTask extends TasksEvent {
  DeleteTask(this.task);
  final Task task;
}

class UpdateTask extends TasksEvent {
  UpdateTask(this.task);
  final Task task;
}
