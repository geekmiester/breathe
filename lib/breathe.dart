import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';
import 'package:breathe/variables.dart';
import 'package:breathe/functions.dart';

class Breathe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new BreatheState();
  }
}

class BreatheState extends StatefulWidget {
  @override
  _Breathe createState() => new _Breathe();
}

class _Breathe extends State<BreatheState> {
  void breathe() async {
    run = true;
    flushbar(context);
    sound(startSound);

    Vibrate.feedback(FeedbackType.success);
    // https://pub.dev/packages/vibrate
    // https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/haptics/

    double breatheInhaleTime = inhaleTime.toDouble();
    double breatheExhaleTime = exhaleTime.toDouble();
    double breatheInhalePause = inhalePause.toDouble();
    double breatheExhalePause = exhalePause.toDouble();

    while (run) {
      if (inhale) {
        setState(() {
          if (circleSize < circle20)
            circleSize = circleSize + 0.006;
          else if (circleSize < circle30)
            circleSize = circleSize + 0.009;
          else if (circleSize > circle97)
            circleSize = circleSize + 0.003;
          else if (circleSize > circle90)
            circleSize = circleSize + 0.005;
          else if (circleSize > circle80)
            circleSize = circleSize + 0.007;
          else
            circleSize = circleSize + 0.01;
        });

        if (circleSize >= maxCircleSize) {
          inhale = false;
          sound(pauseSound);
          await pause(
              Duration(milliseconds: (breatheInhalePause * 1000).toInt()));
          sound(exhaleSound);
        }

        await pause(Duration(milliseconds: (breatheInhaleTime * 10).toInt()));
      } else {
        setState(() {
          if (circleSize < circle13)
            circleSize = circleSize - 0.002;
          else if (circleSize < circle20)
            circleSize = circleSize - 0.004;
          else if (circleSize < circle30)
            circleSize = circleSize - 0.007;
          else
            circleSize = circleSize - 0.01;
        });

        if (circleSize <= minCircleSize) {
          inhale = true;
          breathCount++;

          if (breathCount >=
              (duration * 60) /
                  (inhaleTime + inhalePause + exhaleTime + exhalePause)) {
            breathCount = 0;
            sound(endSound);
            Vibrate.feedback(FeedbackType.error);
            run = false;
          }

          if (run) {
            sound(pauseSound);
            await pause(
                Duration(milliseconds: (breatheExhalePause * 1000).toInt()));
            sound(inhaleSound);
          }

          if (increasing) {
            breatheInhaleTime = breatheInhaleTime + inhaleTime * increaseFactor;
            breatheInhalePause =
                breatheInhalePause + inhalePause * increaseFactor;
            breatheExhaleTime = breatheExhaleTime + exhaleTime * increaseFactor;
            breatheExhalePause =
                breatheExhalePause + exhalePause * increaseFactor;
          }
        }
        await pause(Duration(milliseconds: (breatheExhaleTime * 10).toInt()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: AspectRatio(
              aspectRatio: 1 / 1.8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(introImage),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if (run) {
                  resetCircle();
                } else {
                  breathe();
                  introImage = emptyImage;
                }
              },
              onDoubleTap: () {
                if (run) {
                  resetCircle();
                } else {
                  breathe();
                  introImage = emptyImage;
                }
              },
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: FractionallySizedBox(
                  heightFactor: circleSize,
                  widthFactor: circleSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(circleImage),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
