import 'package:breathe/techniques.dart';
import 'package:flutter/material.dart';

String name = '';
String endSound = 'end.mp3';
String startSound = 'start.mp3';
String inhaleSound = 'inhale.mp3';
String exhaleSound = 'exhale.mp3';
String inhalePauseSound = 'inhalePause.mp3';
String exhalePauseSound = 'exhalePause.mp3';
String circleImage = 'assets/circle.jpg';

String introImage = 'assets/intro.jpg';
String emptyImage = 'assets/empty.jpg';

IconData fabBreatheIcon = Icons.more_horiz;

IconData fabSettingsIcon = Icons.check;

double fontSize = 25;
double captionFontSize = 30;

FontWeight fontWeight = FontWeight.w400;

Color textColor = Colors.amberAccent[100];

Color secondaryColor = Colors.amberAccent[400];

Color iconColor = Colors.amberAccent[700];

DateTime time = DateTime.now();

bool notificationEnabled = false;

bool increasing = false;

bool vibration = false;

double increaseFactor = 0.02;

int breathingTechnique = 3;

int starts = 0;
int duration = 3;

int inhaleTime = techniques[breathingTechnique]['inhaleTime'];
int inhalePause = techniques[breathingTechnique]['inhalePause'];
int exhaleTime = techniques[breathingTechnique]['exhaleTime'];
int exhalePause = techniques[breathingTechnique]['exhalePause'];

int customInhaleTime = 5;
int customInhalePause = 0;
int customExhaleTime = 5;
int customExhalePause = 0;

bool run = false;
bool inhale = true;
bool showIntro = true;

int breathCount = 0;
int starthashCode = 0;

double minCircleSize = 0.1;
double maxCircleSize = 0.9;
double circleSize = minCircleSize;

double circle13 = maxCircleSize * 0.13;
double circle20 = maxCircleSize * 0.20;
double circle30 = maxCircleSize * 0.30;
double circle80 = maxCircleSize * 0.80;
double circle90 = maxCircleSize * 0.90;
double circle97 = maxCircleSize * 0.97;
