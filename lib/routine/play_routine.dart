import 'package:flutter/material.dart';
import 'package:custom_timer/custom_timer.dart';

import 'routine.dart';
import 'task.dart';
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
  int taskIndex = 0;

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

  // remainingCount
  int get remainingCount => widget.routine.tasks.length - (taskIndex + 1);

  // remainingString (ex. "10 more = 4 min")
  String get remainingString =>
      (remainingCount > 0) ? "$remainingCount more = ? min" : "";

  // nextMoveString (ex. "Next: Jumping Jacks")
  String get nextMoveString => (remainingCount > 0)
      ? "Next: ${widget.routine.tasks[taskIndex + 1].moveName}"
      : "";

  // Timer Controller
  late final CustomTimerController _controller = CustomTimerController(
    vsync: this,
    begin: const Duration(),
    end: const Duration(),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.seconds,
  );

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    Task task = widget.routine.tasks[taskIndex];

    // set Timer Controller to task.moveSeconds
    _controller.begin = Duration(seconds: task.moveSeconds);
    _controller.jumpTo(Duration(seconds: task.moveSeconds));

    // Listen for Timer Controller to reach "finished"
    _controller.state.addListener(() {
      if (_controller.state.value == CustomTimerState.finished) {
        nextTask();
        _controller.start();
      }
    });

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
            CustomTimer(
              controller: _controller,
              builder: (state, remaining) {
                int totalSecondsRemaining =
                    (remaining.duration.inMilliseconds / 1000).round();
                int minutesRemaining = (totalSecondsRemaining / 60).floor();
                int secondsRemaining = totalSecondsRemaining % 60;
                String timerString =
                    "$minutesRemaining:${secondsRemaining.toString().padLeft(2, "0")}";
                return Text(timerString, style: textTheme.headlineMedium);
              },
            ),

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
                  child: const Icon(Icons.play_arrow),
                  onPressed: () {
                    if (_controller.state.value == CustomTimerState.counting) {
                      _controller.pause();
                    } else {
                      _controller.start();
                    }
                  },
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
