part of 'dailytask_bloc.dart';

@immutable
abstract class DailyTaskEvent {}

class InitDailyTaskValue extends DailyTaskEvent {
  final TaskDaily dailyTask;
  InitDailyTaskValue(this.dailyTask);
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
