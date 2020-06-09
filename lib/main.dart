import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// todo まずstatefulで作ってからprovider管理にする
class _MyHomePageState extends State<MyHomePage> {
  static bool _isCounting = false;
  static int _defaultSeconds = 10;
  static int _seconds = _defaultSeconds;

  // todo タイマー秒数の管理・変換をどうするか
  // todo パフォーマンス度外視で作ってみる

  Timer _timer;

  void _handleTimer() {
    setState(() {
      _isCounting = !_isCounting;
    });

    if (_isCounting) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds--;
        });
        if (_seconds <= 0) {
          _showFinishDialog();
          _timer.cancel();
        }
      });
    } else {
      _timer.cancel();
    }
  }

  void _showFinishDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('時間切れです！ \n 減点 3割')),
            content: Text('ゲームを終了します。'),
            actions: <Widget>[
              RaisedButton(
                child: Text('是非もなし'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

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
  void initState() {
    final Duration counts = Duration(seconds: 30);
    int sec = 3;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String _remainingTime = _printDuration(Duration(seconds: _seconds));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                Expanded(
                    child: Center(
                        child: Text(
                  _remainingTime,
                  style: const TextStyle(
                      fontSize: 56.0, fontWeight: FontWeight.bold),
                ))),
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
                    _handleTimer();
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
                    setState(() {
                      _seconds = _defaultSeconds;
                      _isCounting = false;
                    });
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
