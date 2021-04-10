part of 'dailytask_bloc.dart';

@immutable
abstract class DailyTaskEvent {}

class InitDailyTaskValues extends DailyTaskEvent {
  final TaskDaily dailyTask;
  InitDailyTaskValues(this.dailyTask);
}

class CountDown extends DailyTaskEvent {
  CountDown(this.dailyTask);
  // final int elapsedSeconds;
  final TaskDaily dailyTask;
}

class StartCountDown extends DailyTaskEvent {
  StartCountDown(this.dailyTask, this.secondsLeft);
  final int secondsLeft;
  final TaskDaily dailyTask;
}

class StopCountDown extends DailyTaskEvent {
  StopCountDown(this.taskDaily, this.countdownValue);
  final TaskDaily taskDaily;
  final int countdownValue;
}
