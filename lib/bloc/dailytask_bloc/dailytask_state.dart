part of 'dailytask_bloc.dart';

@immutable
abstract class DailyTaskState {}

class DailyTaskDefault extends DailyTaskState {}

class DailyTaskInitial extends DailyTaskState {
  final TaskDaily dailyTask;
  DailyTaskInitial(this.dailyTask);
}

//this updates the UI
class DailyTaskCountDownStarted extends DailyTaskState {
  final int countDownValue;
  DailyTaskCountDownStarted(this.countDownValue);
}

// this updates the db
class CountDownStopped extends DailyTaskState {
  final int timeLeft;
  CountDownStopped(this.timeLeft);
}
