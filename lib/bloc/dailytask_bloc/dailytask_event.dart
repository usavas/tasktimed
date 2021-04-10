part of 'dailytask_bloc.dart';

@immutable
abstract class DailyTaskEvent {}

class InitDailyTaskValues extends DailyTaskEvent {
  final TaskDaily dailyTask;
  InitDailyTaskValues(this.dailyTask);
}

class StartCountDown extends DailyTaskEvent {
  StartCountDown(this.secondsLeft);
  final int secondsLeft;
}

class StopCountDown extends DailyTaskEvent {
  StopCountDown(this.taskDaily, this.countdownValue);
  final TaskDaily taskDaily;
  final int countdownValue;
}
