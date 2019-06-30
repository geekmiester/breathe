import 'package:flutter/material.dart';

String name = '';
String endSound = 'end.mp3';
String startSound = 'start.mp3';
String pauseSound = 'pause.mp3';
String inhaleSound = 'inhale.mp3';
String exhaleSound = 'exhale.mp3';
String circleImage = 'assets/circle.jpg';

String introImage = 'assets/intro.jpg';
String emptyImage = 'assets/empty.jpg';

IconData fabBreatheIcon = Icons.more_horiz;

IconData fabSettingsIcon = Icons.check;

double fontSize = 25;

FontWeight fontWeight = FontWeight.w400;

Color textColor = Colors.amberAccent[100];

Color secondaryColor = Colors.amberAccent[400];

Color iconColor = Colors.amberAccent[700];

DateTime time = DateTime.now();

bool notificationEnabled = false;

int breathingTechnique = 0;

int starts = 0;
int duration = 3;
int inhaleTime = 7;
int exhaleTime = 7;
int inhalePause = 2;
int exhalePause = 4;

int customInhaleTime = 7;
int customExhaleTime = 7;
int customInhalePause = 2;
int customExhalePause = 4;

bool run = false;
bool inhale = true;
bool showIntro = true;

int breathCount = 0;

double minCircleSize = 0.1;
double maxCircleSize = 0.9;
double circleSize = minCircleSize;

double circle13 = maxCircleSize * 0.13;
double circle20 = maxCircleSize * 0.20;
double circle30 = maxCircleSize * 0.30;
double circle80 = maxCircleSize * 0.80;
double circle90 = maxCircleSize * 0.90;
double circle97 = maxCircleSize * 0.97;
