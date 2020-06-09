import 'package:flutter/material.dart';
import 'dart:async';

class TimerModel with ChangeNotifier {
  static int _defaultSeconds = 30;
  int _seconds = _defaultSeconds;
  static bool _isCounting = false;

  Timer _timer;

  get seconds => _seconds;

  void handlerTimer() {
    _isCounting = !_isCounting;

    if (_isCounting) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _seconds--;

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
}