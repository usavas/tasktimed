part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent extends Equatable {
  const TasksEvent();
}

class InitializeDailyTasksBasedOnTasks extends TasksEvent {
  const InitializeDailyTasksBasedOnTasks();

  @override
  List<Object?> get props => [];
}

class AddNewTask extends TasksEvent {
  const AddNewTask(this.task);
  final Task task;

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TasksEvent {
  const DeleteTask(this.task);
  final Task task;

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TasksEvent {
  const UpdateTask(this.task);
  final Task task;

  @override
  List<Object?> get props => [task];
}
