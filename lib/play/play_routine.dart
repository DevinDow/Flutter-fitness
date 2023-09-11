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
  late Task _task; // current Task of the Routine
  String _moveName = ""; // either the current Task's Move or Rest or Done
  String _instructions = ""; // the current Move's Instructions'
  bool resting = false;

  late int _taskIndex; // determines current Task of the Routine
  set taskIndex(int newIndex) {
    // set up the Task at this index
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

    taskIndex =
        0; // have this setter execute to set up everything for first task

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
    } else {
      setState(() {
        _moveName = "Done";
        _instructions = "";
      });
      _timerController.pauseTimer();
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
    if (!resting && _task.restSeconds > 0) {
      // finished move, rest if restSeconds
      setState(() {
        resting = true;
        _moveName = "Rest";
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
