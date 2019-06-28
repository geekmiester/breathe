import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new IntroState();
  }
}

class IntroState extends StatefulWidget {
  @override
  _Intro createState() => new _Intro();
}

class _Intro extends State<IntroState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black);
  }
}
