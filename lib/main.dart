import 'package:coundowntimersample/models/timer.dart';
import 'package:coundowntimersample/ui/stateful_timer.dart';
import 'package:coundowntimersample/ui/timer_with_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerModel>(
          create: (_) => TimerModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TimerWithProvider(), // Providerを使ったケース
//      home: StatefulTimerPage(title: 'Statefulタイマー'), // Stateful Widgetを使ったケース
      ),
    );
  }
}

