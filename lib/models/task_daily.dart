import 'package:todotimer/models/task.dart';

class TaskDaily {
  Task? task;
  int? elapsedSeconds;

  TaskDaily({this.task, this.elapsedSeconds});

  TaskDaily.fromJson(Map<String, dynamic> json)
      : task = Task.fromJson(json['task']),
        elapsedSeconds = json['elapsedSeconds'];

  Map<String, dynamic> toJson() =>
      {'task': task?.toJson(), 'elapsedSeconds': elapsedSeconds};

  TaskDaily copyWith({Task? task, int? elapsedSeconds}) {
    return TaskDaily(
      task: task ?? this.task,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    );
  }
}
