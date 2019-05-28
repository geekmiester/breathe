import 'package:flutter/material.dart';
import 'package:breathe/breathe.dart';
import 'package:breathe/settings.dart';
import 'package:breathe/variables.dart';
import 'package:breathe/functions.dart';

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

  Color iconColor = highlightColor;

  IconData icon = fabBreatheIcon;

  Color iconBackgroundColor = Colors.transparent;

  final List<Widget> tabs = [
    Breathe(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    void button() {
      if (tab == 0) {
        tab = 1;
        icon = fabSettingsIcon;
        setState(() {});
      } else if (tab == 1) {
        tab = 0;
        icon = fabBreatheIcon;
        setState(() {});
      }
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
