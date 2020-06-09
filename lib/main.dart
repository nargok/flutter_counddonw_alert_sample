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
  int _counter = 0;
  static bool _isCounting = false;
  static int _defaultSeconds = 5;
  static int _seconds = _defaultSeconds;

  // todo タイマー秒数の管理・変換をどうするか

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

  @override
  Widget build(BuildContext context) {
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
                  '00:00:0$_seconds',
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
