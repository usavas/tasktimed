import 'package:todotimer/task.dart';

class AlarmService {
  static AlarmService? _instance;
  AlarmService._internal();

  static getInstance() {
    if (_instance == null) {
      _instance = AlarmService._internal();
    }
    return _instance;
  }

  soundAlarmForMin(Task task) {
    // sound alarm
  }

  soundAlarmForMax(Task task) {
    // sound alarm
  }
}
