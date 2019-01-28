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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: pureBlack,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool run = false;

bool inhale = true;

var circleSize = 0.0;

var maxCircleSize = 0.0;

var minCircleSize = 0.0;

// variables

Future pause(Duration d) => new Future.delayed(d);

// async

class _MyHomePageState extends State<MyHomePage> {
  void breathe() async {
    while (run) {
      if (inhale) {
        setState(() {
          // This call to setState tells the Flutter framework that something has
          // changed in this State, which causes it to rerun the build method below
          // so that the display can reflect the updated values.
          circleSize = circleSize;
        });
      } else {
        setState(() {
          circleSize = circleSize;
        });
      }
    }
  }

  void settings() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // get the screen dimensions
    if (width < height)
      maxCircleSize = width * 0.8;
    else if (height < width)
      maxCircleSize = height * 0.8;
    else
      maxCircleSize = 230;
    minCircleSize = maxCircleSize * 0.1;
    circleSize = minCircleSize;
    // set the circle to 10%-80% of the screen, according to (smaller) screen size
    return Scaffold(
      backgroundColor: pureBlack,
      body: GestureDetector(
        onLongPress: () {
          if (run)
            run = false;
          else {
            run = true;
            breathe();
          }
        },
        onDoubleTap: () {
          settings();
        },
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
                width: circleSize - 8,
                height: circleSize - 8,
                decoration: new BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
