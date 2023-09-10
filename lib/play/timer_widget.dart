import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as dev;

import 'timer_controller.dart';

class TaskTimer extends StatefulWidget {
  const TaskTimer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TimerController controller;

  @override
  State<TaskTimer> createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      tick();
    });
  }

  void pauseTimer() {
    timer?.cancel();
  }

  void tick() {
    setState(() {
      final seconds = widget.controller.duration.inSeconds - 1; // count down

      if (seconds < 0) {
        timer?.cancel();
        widget.controller.onFinished.call();
      } else {
        widget.controller.duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutesRemaining = widget.controller.duration.inMinutes.remainder(60);
    final secondsRemaining =
        twoDigits(widget.controller.duration.inSeconds.remainder(60));

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
