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
        title: new Text("Settings"),
      ),
      backgroundColor: pureBlack,
    );
  }
}
