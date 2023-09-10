import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as dev;

class TaskTimer extends StatefulWidget {
  const TaskTimer({
    Key? key,
    required this.duration,
    required this.onFinished,
  }) : super(key: key);

  final Duration duration;
  final Function() onFinished;

  /*void setDuration(Duration newDuration) {
    duration = newDuration;
  }*/

  @override
  State<TaskTimer> createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> {
  var countDownDuration = const Duration();

  late Duration duration;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    countDownDuration = widget.duration;
    startTimer();
    reset();
  }

  void reset() {
    setState(() {
      duration = countDownDuration;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      tick();
    });
  }

  void pauseTimer() {
    timer?.cancel();
    countDownDuration = duration;
  }

  void tick() {
    setState(() {
      final seconds = duration.inSeconds - 1; // count down

      if (seconds < 0) {
        timer?.cancel();
        widget.onFinished.call();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    countDownDuration = widget.duration;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutesRemaining = duration.inMinutes.remainder(60);
    final secondsRemaining = twoDigits(duration.inSeconds.remainder(60));

    /*int totalSecondsRemaining =
        (remaining.duration.inMilliseconds / 1000).round();
    int minutesRemaining = (totalSecondsRemaining / 60).floor();
    int secondsRemaining = totalSecondsRemaining % 60;*/
    String timerString =
        "$minutesRemaining:${secondsRemaining.toString().padLeft(2, "0")}";
    dev.log(timerString, name: "Timer");

    return Text(timerString, style: textTheme.headlineMedium);
  }
}
