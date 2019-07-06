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

    starthashCode = DateTime.now().hashCode;
    int cycleHashCode = starthashCode;

    DateTime maxDuration =
        DateTime.now().add(Duration(minutes: (duration + 2)));

    flushbar(context);
    sound(startSound);

    double breatheInhaleTime = inhaleTime.toDouble();
    double breatheInhalePause = inhalePause.toDouble();
    double breatheExhaleTime = exhaleTime.toDouble();
    double breatheExhalePause = exhalePause.toDouble();

    while ((run) &&
        (cycleHashCode == starthashCode) &&
        // if user stops and starts again, the startHashCode will be different
        // and stop 'old' functions
        // if user puts app in background and comes back later, the function is stopped:
        (DateTime.now().isBefore(maxDuration))) {
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

        await pause(Duration(milliseconds: (breatheInhaleTime * 10).toInt()));

        if (circleSize >= maxCircleSize) {
          inhale = false;
          if (inhalePause > 0) sound(inhalePauseSound);
          await pause(
              Duration(milliseconds: (breatheInhalePause * 1000).toInt()));
          if ((run) && (cycleHashCode == starthashCode)) sound(exhaleSound);
        }
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

        await pause(Duration(milliseconds: (breatheExhaleTime * 10).toInt()));

        if (circleSize <= minCircleSize) {
          inhale = true;
          breathCount++;

          if (breathCount >=
              (duration * 60) /
                  (inhaleTime + inhalePause + exhaleTime + exhalePause)) {
            breathCount = 0;
            sound(endSound);
            hapticFeedback('end');
            run = false;
          }

          if (run) {
            if (exhalePause > 0) sound(exhalePauseSound);
            await pause(
                Duration(milliseconds: (breatheExhalePause * 1000).toInt()));
            if ((run) && (cycleHashCode == starthashCode)) sound(inhaleSound);
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
              onPanDown: (context) {
                if (run) {
                  resetCircle();
                  hapticFeedback('stop');
                } else {
                  breathe();
                  introImage = emptyImage;
                  hapticFeedback('start');
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
