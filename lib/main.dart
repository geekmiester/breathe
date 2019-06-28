import 'package:flutter/material.dart';
import 'package:breathe/breathe.dart';
import 'package:breathe/settings.dart';
import 'package:breathe/variables.dart';
import 'package:breathe/functions.dart';
import 'package:breathe/intro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    load();
    return MaterialApp(
      title: 'breathe',
      debugShowCheckedModeBanner: false,
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

class _MyHomePageState extends State<MyHomePage> {
  int tab = 0;

  IconData icon = fabIntroIcon;

  Color iconBackgroundColor = Colors.transparent;

  final List<Widget> tabs = [
    Intro(),
    Breathe(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    void button() {
      if ((tab == 0) || (tab == 2)) {
        tab = 1;
        icon = fabBreatheIcon;
      } else if (tab == 1) {
        tab = 2;
        icon = fabSettingsIcon;
      }
      setState(() {});
    }

    return Scaffold(
      body: tabs[tab],
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            button();
          },
          elevation: 0,
          child: Icon(icon, color: iconColor),
          backgroundColor: iconBackgroundColor),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
