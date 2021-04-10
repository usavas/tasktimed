part of 'dailytasks_bloc.dart';

@immutable
abstract class DailytasksEvent {}

class AddNewTask extends DailytasksEvent {
  AddNewTask(this.task);
  final Task task;
}

class DeleteTask extends DailytasksEvent {
  DeleteTask(this.task);
  final Task task;
}

class UpdateTask extends DailytasksEvent {
  UpdateTask(this.task);
  final Task task;
}

class StartTimerOnDailyTask extends DailytasksEvent {
  StartTimerOnDailyTask(this.secondsLeft);
  final int secondsLeft;
}

class StopTimerOnDailyTask extends DailytasksEvent {
  StopTimerOnDailyTask();
}
