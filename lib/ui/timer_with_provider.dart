import 'package:flutter/material.dart';
import 'package:coundowntimersample/models/timer.dart';
import 'package:provider/provider.dart';

class TimerWithProvider extends StatelessWidget {

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final _timerModel = Provider.of<TimerModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('タイマーサンプル Providerパターン'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // todo 調整しないと位置がずれる問題あり
//                IconButton(
//                  icon: Icon(Icons.menu, size: 56.0,),
//                  onPressed: () {
//                    debugPrint('menu tapped');
//                  },
//                ),
                Icon(
                  Icons.menu,
                  size: 56.0,
                ),
                Expanded(child: Center(child:
                    Consumer<TimerModel>(builder: (context, timerModel, child) {
                      final String _remainingTime = _printDuration(Duration(seconds: timerModel.seconds));
                      debugPrint(_remainingTime);
                  return Text(
                    _remainingTime,
                    style: const TextStyle(
                        fontSize: 56.0, fontWeight: FontWeight.bold),
                  );
                }))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    'カウント開始',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  onPressed: () {
                    debugPrint('カウント開始');
                    _timerModel.handlerTimer();
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
                RaisedButton(
                  child: Text(
                    'リセット',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    debugPrint('リセット');
                    _timerModel.timerReset();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
