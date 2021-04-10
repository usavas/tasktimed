part of 'dailytask_bloc.dart';

@immutable
abstract class DailyTaskState {
  const DailyTaskState();
}

class DailyTaskDefault extends DailyTaskState {}

class DailyTaskInitial extends DailyTaskState {
  final TaskDaily dailyTask;
  const DailyTaskInitial(this.dailyTask);
}

//this updates the UI
class DailyTaskCountDownStarted extends DailyTaskState {
  final int countDownValue;
  const DailyTaskCountDownStarted(this.countDownValue);
}

// this updates the db
class CountDownStopped extends DailyTaskState {
  final int timeLeft;
  const CountDownStopped(this.timeLeft);
}
