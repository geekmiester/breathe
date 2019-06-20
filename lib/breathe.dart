import 'package:flutter/material.dart';
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
          await pause(Duration(seconds: inhalePause));
          sound(exhaleSound);
        }
        await pause(Duration(milliseconds: (inhaleTime * 10)));
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
            run = false;
          }
          if (run) {
            sound(pauseSound);
            await pause(Duration(seconds: exhalePause));
            sound(inhaleSound);
          }
        }
        await pause(Duration(milliseconds: (exhaleTime * 10)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (run) {
              resetCircle();
            } else {
              breathe();
            }
          },
          onDoubleTap: () {
            if (run) {
              resetCircle();
            } else {
              breathe();
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
    );
  }
}
