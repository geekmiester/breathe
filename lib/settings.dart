import 'package:flutter/material.dart';
import 'package:breathe/main.dart';

void settings(context) {
  Navigator.of(context).push(
    new MaterialPageRoute<dynamic>(
      builder: (context) {
        return new Settings();
      },
    ),
  );
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: new Text("Settings",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
        backgroundColor: pureBlack,
        body: Center(child: MenuState()));
  }
}

class MenuState extends StatefulWidget {
  @override
  Menu createState() => new Menu();
}

class Menu extends State<MenuState> {
  @override
  Widget build(BuildContext context) {
    var hint = "";
    run = false;
    inhale = true;
    breathCount = 0;
    circleSize = 0.1;
    if (starts < 5) {
      hint = "double-click circle any time to reveal settings";
    }
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(duration.toString() + " minutes",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          Slider(
              activeColor: Colors.white,
              value: duration.toDouble(),
              min: 1,
              max: 10,
              onChanged: (double newValue) {
                setState(() {
                  duration = newValue.toInt();
                  save();
                });
              }),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(inhaleTime.toString() + "s " + "inhale",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          Slider(
              activeColor: Colors.white,
              value: inhaleTime.toDouble(),
              min: 1,
              max: 30,
              onChanged: (double newValue) {
                setState(() {
                  inhaleTime = newValue.toInt();
                  save();
                });
              }),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(exhaleTime.toString() + "s " + "exhale",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          Slider(
              activeColor: Colors.white,
              value: exhaleTime.toDouble(),
              min: 1,
              max: 30,
              onChanged: (double newValue) {
                setState(() {
                  exhaleTime = newValue.toInt();
                  save();
                });
              }),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(inhalePause.toString() + "s " + "pause after inhale",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          Slider(
              activeColor: Colors.white,
              value: inhalePause.toDouble(),
              min: 0,
              max: 20,
              onChanged: (double newValue) {
                setState(() {
                  inhalePause = newValue.toInt();
                  save();
                });
              }),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(exhalePause.toString() + "s " + "pause after exhale",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          Slider(
              activeColor: Colors.white,
              value: exhalePause.toDouble(),
              min: 0,
              max: 20,
              onChanged: (double newValue) {
                setState(() {
                  exhalePause = newValue.toInt();
                  save();
                });
              }),
          Padding(padding: EdgeInsets.all(10)),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(hint,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white54)),
          ),
        ],
      ),
    );
  }
}