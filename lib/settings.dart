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
          title: new Text('Settings',
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
    String hint = '';
    run = false;
    inhale = true;
    breathCount = 0;
    circleSize = 0.1;
    if (starts < 8) {
      hint = 'double-click circle any time to reveal settings';
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Text(duration.toString() + ' minutes',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.white)),
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
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(inhaleTime.toString() + 's ' + 'inhale',
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
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(exhaleTime.toString() + 's ' + 'exhale',
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
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(inhalePause.toString() + 's ' + 'pause after inhale',
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
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(exhalePause.toString() + 's ' + 'pause after exhale',
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('what\'s your name?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          TextField(
            autocorrect: false,
            maxLines: 1,
            maxLength: 20,
            textAlign: TextAlign.center,
            onChanged: (input) {
              name = input;
              save();
            },
            controller: TextEditingController(text: name),
            style: TextStyle(fontSize: 25, color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(hint,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white54)),
          Padding(padding: EdgeInsets.only(bottom: 30)),
        ],
      ),
    );
  }
}
