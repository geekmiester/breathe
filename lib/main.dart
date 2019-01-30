import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: pureBlack,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

var inhalePause = 2;

var exhalePause = 4;

var inhaleTime = 7;

var exhaleTime = 7;

// variables for circle speed - all roughly in seconds

bool run = false;

bool inhale = true;

var breathCount = 0;

var maxBreathCount = 15;

var minCircleSize = 30.0;

var maxCircleSize = 300.0;

var circleSize = minCircleSize;

var inhaleSpeed = inhaleTime / 2.2;

var exhaleSpeed = exhaleTime / 2.2;

var circle13 = maxCircleSize * 0.13;

var circle20 = maxCircleSize * 0.20;

var circle30 = maxCircleSize * 0.30;

var circle80 = maxCircleSize * 0.80;

var circle90 = maxCircleSize * 0.90;

var circle97 = maxCircleSize * 0.97;

var inhalePauseInMilliseconds = inhalePause * 1000;

var exhalePauseInMilliseconds = exhalePause * 1000;

var invertedInhaleSpeed = ((1 / inhaleSpeed) * 100).round();

var invertedExhaleSpeed = ((1 / exhaleSpeed) * 100).round();

// variables

Future pause(Duration d) => new Future.delayed(d);

// async

class _MyHomePageState extends State<MyHomePage> {
  void breathe() async {
    while (run) {
      if (inhale) {
        setState(() {
          if (circleSize < circle20)
            circleSize = circleSize + 0.6;
          else if (circleSize < circle30)
            circleSize = circleSize + 0.9;
          else if (circleSize > circle97)
            circleSize = circleSize + 0.3;
          else if (circleSize > circle90)
            circleSize = circleSize + 0.5;
          else if (circleSize > circle80)
            circleSize = circleSize + 0.7;
          else
            circleSize++;
        });
        if (circleSize >= maxCircleSize) {
          inhale = false;
          await pause(Duration(milliseconds: inhalePauseInMilliseconds));
        }
        await pause(Duration(milliseconds: invertedInhaleSpeed));
      } else {
        setState(() {
          if (circleSize < circle13)
            circleSize = circleSize - 0.2;
          else if (circleSize < circle20)
            circleSize = circleSize - 0.4;
          else if (circleSize < circle30)
            circleSize = circleSize - 0.7;
          else
            circleSize--;
        });
        if (circleSize <= minCircleSize) {
          inhale = true;
          breathCount++;
          if (breathCount >= maxBreathCount) {
            breathCount = 0;
            run = false;
          }
          await pause(Duration(milliseconds: exhalePauseInMilliseconds));
        }
        await pause(Duration(milliseconds: invertedExhaleSpeed));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureBlack,
      body: GestureDetector(
        onTap: () {
          if (run)
            run = false;
          else {
            run = true;
            breathe();
          }
        },
        onDoubleTap: () {},
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: circleSize,
                height: circleSize,
                decoration: new BoxDecoration(
                  color: Colors.green[900],
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: circleSize - 10,
                height: circleSize - 10,
                decoration: new BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
