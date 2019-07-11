import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';
import 'package:flushbar/flushbar.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:breathe/variables.dart';
import 'package:breathe/techniques.dart';

AudioCache player = new AudioCache();

Future<void> load() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  name = (settings.getString('name') ?? '');
  starts = (settings.getInt('starts') ?? 0);
  duration = (settings.getInt('duration') ?? 3);
  inhaleTime = (settings.getInt('inhaleTime') ??
      techniques[breathingTechnique]['inhaleTime']);
  inhalePause = (settings.getInt('inhalePause') ??
      techniques[breathingTechnique]['inhalePause']);
  exhaleTime = (settings.getInt('exhaleTime') ??
      techniques[breathingTechnique]['exhaleTime']);
  exhalePause = (settings.getInt('exhalePause') ??
      techniques[breathingTechnique]['exhalePause']);
  customInhaleTime = (settings.getInt('customInhaleTime') ??
      techniques[breathingTechnique]['inhaleTime']);
  customInhalePause = (settings.getInt('customInhalePause') ??
      techniques[breathingTechnique]['inhalePause']);
  customExhaleTime = (settings.getInt('customExhaleTime') ??
      techniques[breathingTechnique]['exhaleTime']);
  customExhalePause = (settings.getInt('customExhalePause') ??
      techniques[breathingTechnique]['exhalePause']);
  endSound = (settings.getString('endSound') ?? 'end.mp3');
  startSound = (settings.getString('startSound') ?? 'start.mp3');
  inhaleSound = (settings.getString('inhaleSound') ?? 'inhale.mp3');
  exhaleSound = (settings.getString('exhaleSound') ?? 'exhale.mp3');
  inhalePauseSound =
      (settings.getString('inhalePauseSound') ?? 'inhalePause.mp3');
  exhalePauseSound =
      (settings.getString('exhalePauseSound') ?? 'exhalePause.mp3');
  circleImage = (settings.getString('circleImage') ?? 'assets/circle.jpg');
  breathingTechnique =
      (settings.getInt('breathingTechnique') ?? breathingTechnique);
  increasing = (settings.getBool('increasing') ?? false);
  notificationEnabled = (settings.getBool('notificationEnabled') ?? false);
  time = DateTime(
      0,
      0,
      0,
      (settings.getInt('notificationHour') ?? (DateTime.now().hour) + 1),
      (settings.getInt('notificationMinute') ?? 0));
  techniques[0]['inhaleTime'] = customInhaleTime;
  techniques[0]['exhaleTime'] = customExhaleTime;
  techniques[0]['inhalePause'] = customInhalePause;
  techniques[0]['exhalePause'] = customExhalePause;
  if (duration == 1) duration = 2;
  // for people updated from recent versions where duration = 1 was possible
}

Future<void> save() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  await settings.setString('name', name);
  await settings.setInt('starts', starts);
  await settings.setInt('duration', duration);
  await settings.setInt('inhaleTime', inhaleTime);
  await settings.setInt('inhalePause', inhalePause);
  await settings.setInt('exhaleTime', exhaleTime);
  await settings.setInt('exhalePause', exhalePause);
  await settings.setInt('customInhaleTime', customInhaleTime);
  await settings.setInt('customInhalePause', customInhalePause);
  await settings.setInt('customExhaleTime', customExhaleTime);
  await settings.setInt('customExhalePause', customExhalePause);
  await settings.setString('endSound', endSound);
  await settings.setString('startSound', startSound);

  await settings.setString('inhaleSound', inhaleSound);
  await settings.setString('exhaleSound', exhaleSound);
  await settings.setString('inhalePauseSound', inhalePauseSound);
  await settings.setString('exhalePauseSound', exhalePauseSound);
  await settings.setString('cirlceImage', circleImage);
  await settings.setInt('breathingTechnique', breathingTechnique);
  await settings.setBool('increasing', increasing);
  await settings.setBool('notificationEnabled', notificationEnabled);
  await settings.setInt('notificationHour', time.hour);
  await settings.setInt('notificationMinute', time.minute);
}

Future pause(Duration d) => new Future.delayed(d);

void sound(sound) {
  player.play(sound);
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

enum hapticFeedbackType { tap, start, stop, end }

void hapticFeedback(hapticFeedbackType feedback) {
  // https://pub.dev/packages/vibrate
  // https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/haptics/
  switch (feedback) {
    case hapticFeedbackType.tap:
      Vibrate.feedback(FeedbackType.light);
      break;
    case hapticFeedbackType.start:
      Vibrate.feedback(FeedbackType.success);
      break;
    case hapticFeedbackType.stop:
      Vibrate.feedback(FeedbackType.warning);
      break;
    case hapticFeedbackType.end:
      Vibrate.feedback(FeedbackType.error);
      break;
  }
}
