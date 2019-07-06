import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:breathe/variables.dart';
import 'package:breathe/functions.dart';
import 'package:breathe/notifications.dart';
import 'package:breathe/techniques.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: Scaffold(backgroundColor: Colors.black),
          title: new Text('Settings',
              style: TextStyle(
                  fontSize: captionFontSize,
                  fontWeight: fontWeight,
                  color: textColor)),
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
  Color notificationButtonColor = secondaryColor;

  Color increasingButtonColor = secondaryColor;

  Icon notificationButtonIcon =
      Icon(Icons.check_box_outline_blank, color: secondaryColor);

  Icon increasingButtonIcon =
      Icon(Icons.check_box_outline_blank, color: secondaryColor);

  void updateTime(TimeOfDay input) {
    if (input != null) {
      time = DateTime(0, 0, 0, input.hour, input.minute);
      notificationEnabled = true;
      updateNotification(false);
    }
  }

  void updateNotification(bool toggle) {
    // (toggle) = when state is changed by user
    if (((!toggle) && (notificationEnabled)) ||
        ((toggle) && (!notificationEnabled))) {
      notificationEnabled = true;
      Notifications.daily(time);
      notificationButtonColor = textColor;
      notificationButtonIcon =
          Icon(Icons.check_box, color: notificationButtonColor);
    } else {
      notificationEnabled = false;
      Notifications.cancel();
      notificationButtonColor = secondaryColor;
      notificationButtonIcon =
          Icon(Icons.check_box_outline_blank, color: notificationButtonColor);
    }
    save();
    setState(() {});
  }

  void updateIncreaseButton(bool toggle) {
    // (toggle) = when state is changed by user
    if (((!toggle) && (increasing)) || ((toggle) && (!increasing))) {
      increasing = true;
      increasingButtonColor = textColor;
      increasingButtonIcon =
          Icon(Icons.check_box, color: increasingButtonColor);
    } else {
      increasing = false;
      increasingButtonColor = secondaryColor;
      increasingButtonIcon =
          Icon(Icons.check_box_outline_blank, color: increasingButtonColor);
    }
    save();
    setState(() {});
  }

  void updateBreathingInterval(String changed) {
    if ('breathingTechnique' == changed) {
      int index = breathingTechnique;
      inhaleTime = techniques[index]['inhaleTime'];
      inhalePause = techniques[index]['inhalePause'];
      exhaleTime = techniques[index]['exhaleTime'];
      exhalePause = techniques[index]['exhalePause'];
    } else {
      breathingTechnique = 0;
      customInhaleTime = inhaleTime;
      customInhalePause = inhalePause;
      customExhaleTime = exhaleTime;
      customExhalePause = exhalePause;

      techniques[0]['inhaleTime'] = customInhaleTime;
      techniques[0]['inhalePause'] = customInhalePause;
      techniques[0]['exhaleTime'] = customExhaleTime;
      techniques[0]['exhalePause'] = customExhalePause;
    }
    save();
    setState(() {});
  }

  Widget breathingTechniquePicker(BuildContext context) {
    return new AlertDialog(
      backgroundColor: Colors.black,
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int index = 0; index < techniques.length; index++)
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  breathingTechnique = index;
                  updateBreathingInterval('breathingTechnique');
                  Navigator.of(context).pop();
                },
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(techniques[index]['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: captionFontSize,
                            fontWeight: fontWeight,
                            color: secondaryColor)),
                    Text(techniques[index]['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: fontWeight,
                            color: iconColor)),
                    Padding(padding: EdgeInsets.only(top: 10)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    resetCircle();
    updateNotification(false);
    updateIncreaseButton(false);
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.black,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 25)),
            Text('breathing technique',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor)),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      breathingTechniquePicker(context),
                );
              },
              child: Text(techniques[breathingTechnique]['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: secondaryColor)),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
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
                  inhaleTime = newValue.toInt();
                  updateBreathingInterval('inhaleTime');
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
                  inhalePause = newValue.toInt();
                  updateBreathingInterval('inhalePause');
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
                  exhaleTime = newValue.toInt();
                  updateBreathingInterval('exhaleTime');
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
                  exhalePause = newValue.toInt();
                  updateBreathingInterval('exhalePause');
                }),
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
                min: 2,
                max: 20,
                onChanged: (double newValue) {
                  setState(() {
                    duration = newValue.toInt();
                    save();
                  });
                }),
            Padding(padding: EdgeInsets.only(top: 25)),
            Padding(
              padding: EdgeInsets.only(left: 13),
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  updateIncreaseButton(true);
                },
                icon: increasingButtonIcon,
                label: Row(
                  children: <Widget>[
                    Text(
                      'increasing',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          color: increasingButtonColor),
                    ),
                    Container(
                      width: 38,
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: Colors.black,
                                  content: Container(
                                      child: Text(
                                          'you begin with the selected rhythm \n \n every cycle the interval becomes slightly longer',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: captionFontSize,
                                              fontWeight: fontWeight,
                                              color: iconColor)))));
                        },
                        child: Icon(Icons.info_outline,
                            color: increasingButtonColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            FlatButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                updateNotification(true);
              },
              icon: notificationButtonIcon,
              label: Text(
                'daily notification',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: notificationButtonColor),
              ),
            ),
            Theme(
              // https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/time_picker.dart
              data: Theme.of(context).copyWith(
                backgroundColor: iconColor,
                dialogBackgroundColor: Colors.black,
                brightness: Brightness.dark,
                accentColor: Colors.black54,
                buttonTheme: ButtonThemeData(
                  colorScheme: ColorScheme.fromSwatch(accentColor: iconColor),
                ),
              ),
              child: new Builder(
                builder: (context) => MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    DateFormat('h:mm a').format(time),
                    style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: secondaryColor),
                  ),
                  onPressed: () async {
                    Future<TimeOfDay> getTime() => showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(time),
                          builder: (BuildContext context, Widget child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                alwaysUse24HourFormat: false,
                                boldText: true,
                              ),
                              child: child,
                            );
                          },
                        );
                    final input = await getTime();
                    return updateTime(input);
                  },
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              cursorColor: iconColor,
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
                  fontSize: fontSize, fontWeight: fontWeight, color: iconColor),
              decoration: InputDecoration(
                hintText: 'your beautiful name',
                hintStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: secondaryColor),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
