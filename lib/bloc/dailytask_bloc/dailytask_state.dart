part of 'dailytask_bloc.dart';

@immutable
abstract class DailyTaskState {}

class TaskInitial extends DailyTaskState {}

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
