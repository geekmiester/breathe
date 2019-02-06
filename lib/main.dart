import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flushbar/flushbar.dart';
import 'package:breathe/settings.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    load();
    return MaterialApp(
      title: 'breathe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: pureBlack,
      ),
      home: MyHomePage(title: 'breathe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const MaterialColor pureBlack = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

var starts;
var duration;
var inhaleTime;
var exhaleTime;
var inhalePause;
var exhalePause;

var run = false;
var inhale = true;
var showIntro = true;

var breathCount = 0;

var minCircleSize = 0.1;
var maxCircleSize = 0.9;
var circleSize = minCircleSize;

var circle13 = maxCircleSize * 0.13;
var circle20 = maxCircleSize * 0.20;
var circle30 = maxCircleSize * 0.30;
var circle80 = maxCircleSize * 0.80;
var circle90 = maxCircleSize * 0.90;
var circle97 = maxCircleSize * 0.97;

Future<void> load() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  starts = (settings.getInt('starts') ?? 0);
  duration = (settings.getInt('duration') ?? 3);
  inhaleTime = (settings.getInt('inhaleTime') ?? 7);
  exhaleTime = (settings.getInt('exhaleTime') ?? 7);
  inhalePause = (settings.getInt('inhalePause') ?? 2);
  exhalePause = (settings.getInt('exhalePause') ?? 4);
}

Future<void> save() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  await settings.setInt('starts', starts);
  await settings.setInt('duration', duration);
  await settings.setInt('inhaleTime', inhaleTime);
  await settings.setInt('exhaleTime', exhaleTime);
  await settings.setInt('inhalePause', inhalePause);
  await settings.setInt('exhalePause', exhalePause);
}

Future pause(Duration d) => new Future.delayed(d);

AudioCache player = new AudioCache();

void sound() {
  player.play('gong.aac');
}

void flushbar(context) async {
  if (showIntro) {
    showIntro = false;
    starts++;
    save();
    var message;
    var title = "You are valuable!";
    var length = 5;
    if (starts < 3) {
      title = "Welcome!";
      message = "good to see you!";
    } else if ((starts % 10) == 0) {
      title = "You are awesome!";
      message = "keep up with regular meditation";
    } else if ((starts % 5) == 0)
      message = "good to have you back!";
    else if ((starts % 3 == 0))
      message = "enjoy your short break";
    else
      message = "keep breathing";
    Flushbar()
      ..titleText = new Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.amber[100],
          ))
      ..messageText = new Text(message,
          style: TextStyle(
            fontSize: 18,
            color: Colors.amber[200],
          ))
      ..duration = Duration(seconds: length)
      ..backgroundColor = Colors.black
      ..mainButton = FlatButton(
        onPressed: () {
          settings(context);
        },
        child: Text(
          "SETTINGS",
          style: TextStyle(fontSize: 14, color: Colors.amber),
        ),
      )
      ..show(context);
    await pause(Duration(seconds: length));
    showIntro = true;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  void breathe() async {
    while (run) {
      if (inhale) {
        setState(() {
          if (circleSize < circle20)
            circleSize = circleSize + 0.006;
          else if (circleSize < circle30)
            circleSize = circleSize + 0.009;
          else if (circleSize > circle97)
            circleSize = circleSize + 0.003;
          else if (circleSize > circle90)
            circleSize = circleSize + 0.005;
          else if (circleSize > circle80)
            circleSize = circleSize + 0.007;
          else
            circleSize = circleSize + 0.01;
        });
        if (circleSize >= maxCircleSize) {
          inhale = false;
          sound();
          await pause(Duration(seconds: inhalePause));
          sound();
        }
        await pause(Duration(milliseconds: (inhaleTime * 10)));
      } else {
        setState(() {
          if (circleSize < circle13)
            circleSize = circleSize - 0.002;
          else if (circleSize < circle20)
            circleSize = circleSize - 0.004;
          else if (circleSize < circle30)
            circleSize = circleSize - 0.007;
          else
            circleSize = circleSize - 0.01;
        });
        if (circleSize <= minCircleSize) {
          inhale = true;
          breathCount++;
          if (breathCount >=
              (duration * 60) /
                  (inhaleTime + inhalePause + exhaleTime + exhalePause)) {
            breathCount = 0;
            run = false;
          }
          sound();
          await pause(Duration(seconds: exhalePause));
          sound();
        }
        await pause(Duration(milliseconds: (exhaleTime * 10)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureBlack,
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (run)
              run = false;
            else {
              run = true;
              breathe();
              flushbar(context);
            }
          },
          onDoubleTap: () {
            settings(context);
          },
          child: FractionallySizedBox(
            heightFactor: circleSize,
            widthFactor: circleSize,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/circle.jpg'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
