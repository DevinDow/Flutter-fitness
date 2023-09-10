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
  State<PlayRoutine> createState() => _TaskState();
}

class _TaskState extends State<PlayRoutine>
    with SingleTickerProviderStateMixin {
  // taskIndex determines which Task of the Routine
  int taskIndex = 0;

  // Timer Controller
  late final TimerController _timerController = TimerController(
    duration: const Duration(),
    onFinished: onTimerFinished,
  );

  // remainingCount
  int get remainingCount => widget.routine.tasks.length - (taskIndex + 1);

  // remainingString (ex. "10 more = 4 min")
  String get remainingString =>
      (remainingCount > 0) ? "$remainingCount more = ? min" : "";

  // nextMoveString (ex. "Next: Jumping Jacks")
  String get nextMoveString => (remainingCount > 0)
      ? "Next: ${widget.routine.tasks[taskIndex + 1].moveName}"
      : "";

  // Methods
  void nextTask() {
    if (taskIndex < widget.routine.tasks.length - 1) {
      setState(() {
        taskIndex++;
      });
    }
  }

  void prevTask() {
    if (taskIndex > 0) {
      setState(() {
        taskIndex--;
      });
    }
  }

  void playPause() {}

  void onTimerFinished() {
    nextTask();
  }

  // Overrides
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    Task task = widget.routine.tasks[taskIndex];
    dev.log("moveName = ${task.moveName}, duration = ${task.moveSeconds}",
        name: "PlayRoutine");
    _timerController.duration = Duration(seconds: task.moveSeconds);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Move Name
            Text(
              task.moveName,
              style: textTheme.headlineLarge,
            ),

            // Instructions
            Text(
              task.instructions,
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
                        painter: MovePainter(moveName: task.moveName)),
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
