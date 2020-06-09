import 'package:flutter/foundation.dart';
import 'dart:async';

class TimerModel with ChangeNotifier {
  static int _defaultSeconds = 30;
  int _seconds = _defaultSeconds;
  static bool _isCounting = false;

  Timer _timer;

  get seconds => _seconds;

  void _countDown() {
    _seconds--;
    notifyListeners();
  }

  void handlerTimer() {
    print('handleTimer started!');
    _isCounting = !_isCounting;

    if (_isCounting) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _countDown();
        print(_seconds);

        if (_seconds <= 0) {
          // todo 0秒になったときの挙動はUIに持たせる
          _timer.cancel();
        }
      });
    } else {
      _timer.cancel();
    }

    notifyListeners();
  }

  void timerReset() {
    _seconds = _defaultSeconds;
    _isCounting = false;
    notifyListeners();
  }
}