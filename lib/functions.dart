import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:breathe/variables.dart';

AudioCache player = new AudioCache();

Future<void> load() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  name = (settings.getString('name') ?? '');
  starts = (settings.getInt('starts') ?? 0);
  duration = (settings.getInt('duration') ?? 3);
  inhaleTime = (settings.getInt('inhaleTime') ?? 7);
  exhaleTime = (settings.getInt('exhaleTime') ?? 7);
  inhalePause = (settings.getInt('inhalePause') ?? 2);
  exhalePause = (settings.getInt('exhalePause') ?? 4);
  endSound = (settings.getString('endSound') ?? 'end.mp3');
  startSound = (settings.getString('startSound') ?? 'start.mp3');
  pauseSound = (settings.getString('pauseSound') ?? 'pause.mp3');
  inhaleSound = (settings.getString('inhaleSound') ?? 'inhale.mp3');
  inhaleSound = (settings.getString('exhaleSound') ?? 'exhale.mp3');
  circleImage = (settings.getString('circleImage') ?? 'assets/circle.jpg');
}

Future<void> save() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  await settings.setString('name', name);
  await settings.setInt('starts', starts);
  await settings.setInt('duration', duration);
  await settings.setInt('inhaleTime', inhaleTime);
  await settings.setInt('exhaleTime', exhaleTime);
  await settings.setInt('inhalePause', inhalePause);
  await settings.setInt('exhalePause', exhalePause);
  await settings.setString('endSound', endSound);
  await settings.setString('startSound', startSound);
  await settings.setString('pauseSound', pauseSound);
  await settings.setString('inhaleSound', inhaleSound);
  await settings.setString('exhaleSound', exhaleSound);
  await settings.setString('cirlceImage', circleImage);
}

Future pause(Duration d) => new Future.delayed(d);

void sound(s) {
  player.play(s);
}

void flushbar(context) async {
  if (showIntro) {
    showIntro = false;
    starts++;
    save();
    String message = ' ';
    String nameFirst = '';
    String nameLast = '';
    if ((name != null) && (name != '')) {
      nameFirst = name + ', ';
      nameLast = ', ' + name;
    }
    String title = 'You are valuable' + nameLast + '!';
    int length = 5;
    if (starts < 3) {
      title = 'Welcome' + nameLast + '!';
      message = 'good to see you!';
    } else if ((starts % 10) == 0) {
      title = nameFirst + 'you are awesome!';
      message = 'keep up with regular meditation';
    } else if ((starts % 5) == 0)
      message = 'good to have you back!';
    else if ((starts % 3 == 0))
      message = 'enjoy your short break';
    else
      message = 'keep breathing';
    Flushbar(
      titleText: new Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.amber[100],
          )),
      messageText: new Text(message,
          style: TextStyle(
            fontSize: 18,
            fontWeight: fontWeight,
            color: Colors.amber[200],
          )),
      duration: Duration(seconds: length),
      backgroundColor: Colors.black,
    )..show(context);
    await pause(Duration(seconds: length));
    showIntro = true;
  }
}

void resetCircle() {
  run = false;
  inhale = true;
  breathCount = 0;
  circleSize = 0.1;
}
