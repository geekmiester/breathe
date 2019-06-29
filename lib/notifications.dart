import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:breathe/variables.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class Notifications {
  static Future onSelectNotification(String sort) async {}

  static Future cancel() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future daily(DateTime time) async {
    var _sound = 'gong';
    var _message = 'time to refuel your energy 🤗';
    Time _time = Time(time.hour, time.minute);
    if ((name != null) && (name != '')) {
      _message = name + ', ' + _message;
    }
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'com.achimsapps.breathe', 'achimsapps', 'breathe',
        sound: _sound, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: true, sound: _sound + '.aiff');
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    if (time != null) {
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        _message,
        '',
        _time,
        platformChannelSpecifics,
        payload: '0',
      );
    }
  }
}
