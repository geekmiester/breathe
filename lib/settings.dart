import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:breathe/variables.dart';
import 'package:breathe/functions.dart';
import 'package:breathe/notifications.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: Scaffold(backgroundColor: Colors.black),
          title: new Text('Settings',
              style: TextStyle(
                  fontSize: 30, fontWeight: fontWeight, color: textColor)),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Center(child: SettingsState()));
  }
}

class SettingsState extends StatefulWidget {
  @override
  _Settings createState() => new _Settings();
}

class _Settings extends State<SettingsState> {
  void changeTime(input) {
    if (input != null) {
      time = DateTime(0, 0, 0, input.hour, input.minute);
      Notifications.daily(time);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    resetCircle();
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.black,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(duration.toString() + ' minutes',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor)),
            Slider(
                activeColor: secondaryColor,
                inactiveColor: Colors.black,
                value: duration.toDouble(),
                min: 1,
                max: 10,
                onChanged: (double newValue) {
                  setState(() {
                    duration = newValue.toInt();
                    save();
                  });
                }),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(inhaleTime.toString() + 's ' + 'inhale',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor)),
            Slider(
                activeColor: secondaryColor,
                inactiveColor: Colors.black,
                value: inhaleTime.toDouble(),
                min: 1,
                max: 30,
                onChanged: (double newValue) {
                  setState(() {
                    inhaleTime = newValue.toInt();
                    save();
                  });
                }),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(exhaleTime.toString() + 's ' + 'exhale',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor)),
            Slider(
                activeColor: secondaryColor,
                inactiveColor: Colors.black,
                value: exhaleTime.toDouble(),
                min: 1,
                max: 30,
                onChanged: (double newValue) {
                  setState(() {
                    exhaleTime = newValue.toInt();
                    save();
                  });
                }),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(inhalePause.toString() + 's ' + 'pause after inhale',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor)),
            Slider(
                activeColor: secondaryColor,
                inactiveColor: Colors.black,
                value: inhalePause.toDouble(),
                min: 0,
                max: 20,
                onChanged: (double newValue) {
                  setState(() {
                    inhalePause = newValue.toInt();
                    save();
                  });
                }),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(exhalePause.toString() + 's ' + 'pause after exhale',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor)),
            Slider(
                activeColor: secondaryColor,
                inactiveColor: Colors.black,
                value: exhalePause.toDouble(),
                min: 0,
                max: 20,
                onChanged: (double newValue) {
                  setState(() {
                    exhalePause = newValue.toInt();
                    save();
                  });
                }),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              cursorColor: secondaryColor,
              keyboardAppearance: Brightness.dark,
              autocorrect: false,
              maxLines: 1,
              maxLength: 20,
              textAlign: TextAlign.center,
              onChanged: (input) {
                name = input;
                save();
              },
              controller: TextEditingController(text: name),
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: secondaryColor),
              decoration: InputDecoration(
                hintText: 'your beautiful name',
                hintStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: secondaryColor),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Text('daily notification',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor)),
            Theme(
              // https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/time_picker.dart
              data: Theme.of(context).copyWith(
                backgroundColor: secondaryColor,
                dialogBackgroundColor: Colors.black,
                brightness: Brightness.dark,
                accentColor: Colors.black54,
                buttonTheme: ButtonThemeData(
                  colorScheme:
                      ColorScheme.fromSwatch(accentColor: secondaryColor),
                ),
              ),
              child: new Builder(
                builder: (context) => MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        DateFormat('H:mm').format(time),
                        style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: fontWeight,
                            color: secondaryColor),
                      ),
                      onPressed: () async {
                        Future<TimeOfDay> getDuration() => showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(time),
                              builder: (BuildContext context, Widget child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child,
                                );
                              },
                            );
                        final input = await getDuration();
                        return changeTime(input);
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
