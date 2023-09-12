import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'timer_controller.dart';
import 'timer_widget.dart';
import '../routine/routine.dart';
import '../routine/task.dart';
import '../move/move_library.dart';
import '../move/move_painter.dart';

/// Widget for UI to Play a Routine by stepping through the Tasks/Moves using a Timer and Buttons.
class PlayRoutine extends StatefulWidget {
  /// The Routine to play.
  final Routine routine;

  const PlayRoutine({
    super.key,
    required this.routine,
  });

  @override
  State<PlayRoutine> createState() => _PlayRoutineState();
}

class _PlayRoutineState extends State<PlayRoutine> {
  /// the current Task of the Routine
  late Task _task;

  /// either the current Task's Move or Rest or Done
  String _moveName = "";

  /// the current Move's Instructions'
  String _instructions = "";

  /// Waiting _task.restSeconds in the Rest Move before advancing to next Move.
  bool resting = false;

  /// Determines current Task of the Routine.
  late int _taskIndex;

  /// Sets up the Task at this index.
  set taskIndex(int newIndex) {
    setState(() {
      _taskIndex = newIndex;
      _task = widget.routine.tasks[_taskIndex];
      _moveName = _task.moveName;
      if (_task.moveSeconds > 0) {
        _timerController.remaining = Duration(seconds: _task.moveSeconds);
        _instructions = _task.instructions;
        resting = false;
      } else {
        _timerController.pauseTimer();
      }
    });
  }

  late final TimerController _timerController;

  @override
  void initState() {
    _timerController = TimerController(
      onFinished: onTimerFinished,
    );

    taskIndex = 0; // set up the first Task

    super.initState();
  }

  /// remainingCount = integer count of Tasks remaining in this Routine
  int get remainingCount => widget.routine.tasks.length - (_taskIndex + 1);

  /// remainingString (ex. "10 more = 4 min")
  String get remainingString =>
      (remainingCount > 0) ? "$remainingCount more = ? min" : "";

  /// nextMoveString (ex. "Next: Jumping Jacks")
  String get nextMoveString => (remainingCount > 0)
      ? "Next: ${widget.routine.tasks[_taskIndex + 1].moveName}"
      : "";

  // Methods

  /// Advance to next Task or DONE.
  void nextTask() {
    if (_taskIndex < widget.routine.tasks.length - 1) {
      taskIndex = _taskIndex + 1;
    } else {
      setState(() {
        _moveName = MoveLibrary.DONE;
        _instructions = "";
        _timerController.remaining = const Duration();
      });
      _timerController.pauseTimer();
    }
  }

  /// Go back to previous Task.
  /// Resting restarts current Task.
  /// One-Move Routines simply restart.
  void prevTask() {
    if (resting) {
      // back to current Move from Resting
      taskIndex = _taskIndex;
    } else if (_taskIndex > 0) {
      // Previous Task
      taskIndex = _taskIndex - 1;
    } else {
      // restart one-Move Routines
      taskIndex = _taskIndex;
    }
  }

  void playPause() {
    _timerController.toggleTimer();
  }

  void onTimerFinished() {
    if (!resting && _task.restSeconds > 0) {
      // finished move, rest if restSeconds
      setState(() {
        resting = true;
        _moveName = MoveLibrary.REST;
        _instructions = "";
        _timerController.remaining = Duration(seconds: _task.restSeconds);
      });
    } else {
      nextTask();
    }
  }

  // Overrides
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    dev.log(
        "moveName = $_moveName, move seconds = ${_task.moveSeconds}, rest seconds = ${_task.restSeconds}",
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
              _moveName,
              style: textTheme.headlineLarge,
            ),

            // Instructions
            Text(
              _instructions,
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
                    child:
                        CustomPaint(painter: MovePainter(moveName: _moveName)),
                  ),
                ),
              ),
            ),

            // Timer
            Timer(controller: _timerController),

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
