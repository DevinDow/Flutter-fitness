import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'timer_controller.dart';

class Timer extends StatefulWidget {
  const Timer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TimerController controller;

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  void initState() {
    widget.controller.onTick = () {
      setState(() {}); // cause TaskTimer widget to build() on each tick
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutesRemaining =
        widget.controller.remaining.inMinutes.remainder(60);
    final secondsRemaining =
        twoDigits(widget.controller.remaining.inSeconds.remainder(60));

    String timerString =
        "$minutesRemaining:${secondsRemaining.toString().padLeft(2, "0")}";
    //dev.log("timerString = $timerString", name: "Timer");

    return Text(timerString, style: textTheme.headlineMedium);
  }

  @override
  void dispose() {
    dev.log("dispose()", name: "Timer");
    widget.controller.pauseTimer();
    super.dispose();
  }
}
