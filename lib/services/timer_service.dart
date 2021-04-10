import 'dart:async';

class TimerService {
  final int startValue;
  late int _currentValue;
  late Stream<int> _countDownStream;

  TimerService(this.startValue);

  Stream<int> startTimer() {
    _countDownStream = Stream.periodic(Duration(seconds: 1), (i) {
      _currentValue = startValue - i;
      return _currentValue;
    });

    return _countDownStream;
  }
}
