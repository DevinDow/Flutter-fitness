import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'timer_controller.dart';
import 'timer_widget.dart';
import '../routine/routine.dart';
import '../routine/task.dart';
import '../move/move_painter.dart';

class PlayRoutine extends StatefulWidget {
  final Routine routine;

  const PlayRoutine({
    super.key,
    required this.routine,
  });

  @override
  State<PlayRoutine> createState() => _PlayRoutineState();
}

class _PlayRoutineState extends State<PlayRoutine> {
  int _taskIndex = 0; // determines current Task of the Routine
  set taskIndex(int newIndex) {
    _taskIndex = newIndex;
    _task = widget.routine.tasks[_taskIndex];
    if (_task.moveSeconds > 0) {
      _timerController.remaining = Duration(seconds: _task.moveSeconds);
    } else {
      _timerController.pauseTimer();
    }
  }

  late Task _task; // current Task of the Routine
  late final TimerController _timerController;

  @override
  void initState() {
    _task = widget.routine.tasks[_taskIndex];

    _timerController = TimerController(
      remaining: Duration(seconds: _task.moveSeconds),
      onFinished: onTimerFinished,
    );
    super.initState();
  }

  // remainingCount
  int get remainingCount => widget.routine.tasks.length - (_taskIndex + 1);

  // remainingString (ex. "10 more = 4 min")
  String get remainingString =>
      (remainingCount > 0) ? "$remainingCount more = ? min" : "";

  // nextMoveString (ex. "Next: Jumping Jacks")
  String get nextMoveString => (remainingCount > 0)
      ? "Next: ${widget.routine.tasks[_taskIndex + 1].moveName}"
      : "";

  // Methods
  void nextTask() {
    if (_taskIndex < widget.routine.tasks.length - 1) {
      setState(() {
        taskIndex = _taskIndex + 1;
      });
    }
  }

  void prevTask() {
    if (_taskIndex > 0) {
      setState(() {
        taskIndex = _taskIndex - 1;
      });
    }
  }

  void playPause() {
    _timerController.toggleTimer();
  }

  void onTimerFinished() {
    nextTask();
  }

  // Overrides
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    dev.log("moveName = ${_task.moveName}, duration = ${_task.moveSeconds}",
        name: "PlayRoutine");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Move Name
            Text(
              _task.moveName,
              style: textTheme.headlineLarge,
            ),

            // Instructions
            Text(
              _task.instructions,
              style: textTheme.titleMedium,
            ),

            // Canvas
            // - let it expand as tall as Column allows, then make Width the same so it's a square
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: LayoutBuilder(
                  builder: (_, constraints) => SizedBox(
                    width: constraints
                        .maxHeight, // make it a square based on Expanded's Height
                    child: CustomPaint(
                        painter: MovePainter(moveName: _task.moveName)),
                  ),
                ),
              ),
            ),

            // Timer
            TaskTimer(controller: _timerController),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous
                ElevatedButton(
                  onPressed: prevTask,
                  child: const Icon(Icons.skip_previous),
                ),

                // Play/Pause
                ElevatedButton(
                  onPressed: playPause,
                  child: const Icon(Icons.play_arrow),
                ),

                // Next
                ElevatedButton(
                  onPressed: nextTask,
                  child: const Icon(Icons.skip_next),
                ),
              ],
            ),

            // Next/Remaining
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nextMoveString, // "Next: Jumping Jacks"
                  style: textTheme.bodyLarge,
                ),
                Text(
                  remainingString, // "10 more = 4 min"
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
