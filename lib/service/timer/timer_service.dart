import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerService {
  Timer? _timer;

  void startTimer(Duration duration, VoidCallback callback) {
    _timer?.cancel();

    _timer = Timer(duration, callback);
  }

  void startPerodicTimer(Duration duration, void Function(Timer) callback) {
    _timer?.cancel();

    _timer = Timer.periodic(duration, callback);
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  bool get isTimerActive => _timer?.isActive ?? false;
}
