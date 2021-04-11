part of 'dailytask_bloc.dart';

@immutable
abstract class DailyTaskState {}

class DailyTaskLoading extends DailyTaskState {}

class DailyTaskInitial extends DailyTaskState {
  final TaskDaily dailyTask;
  DailyTaskInitial(this.dailyTask);
}

class CountDownState extends DailyTaskState {
  final TaskDaily dailyTask;
  final int timerTickValue;
  CountDownState(this.dailyTask, this.timerTickValue);
}

// this updates the db
class CountDownStopped extends DailyTaskState {
  final int timeLeft;
  final TaskDaily dailyTask;
  CountDownStopped(this.dailyTask, this.timeLeft);
}
