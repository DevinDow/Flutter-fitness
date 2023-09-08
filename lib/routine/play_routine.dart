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

  // remainingCount
  int get remainingCount => widget.routine.tasks.length - (taskIndex + 1);

  // remainingString (ex. "10 more = 4 min")
  String get remainingString =>
      (remainingCount > 0) ? "$remainingCount more = ? min" : "";

  // nextMoveString (ex. "Next: Jumping Jacks")
  String get nextMoveString => (remainingCount > 0)
      ? "Next: ${widget.routine.tasks[taskIndex + 1].moveName}"
      : "";

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
    _controller.begin = Duration(seconds: task.moveSeconds);
    _controller.jumpTo(Duration(seconds: task.moveSeconds));

    _controller.state.addListener(() {
      if (_controller.state.value == CustomTimerState.finished) {
        setState(() {
          if (taskIndex < widget.routine.tasks.length - 1) {
            taskIndex++;
            _controller.start();
          }
        });
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
                // Build the widget you want!
                return Column(
                  children: [
                    Text(
                      "${remaining.minutes}:${remaining.seconds}",
                      style: textTheme.headlineMedium,
                    ),
                  ],
                );
              },
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous
                ElevatedButton(
                  child: const Icon(Icons.skip_previous),
                  onPressed: () {
                    setState(() {
                      if (taskIndex > 0) {
                        taskIndex--;
                      }
                    });
                  },
                ),

                // Play
                ElevatedButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () {
                    _controller.start();
                  },
                ),

                // Pause
                ElevatedButton(
                  child: const Icon(Icons.pause),
                  onPressed: () {
                    _controller.pause();
                  },
                ),

                // Next
                ElevatedButton(
                  child: const Icon(Icons.skip_next),
                  onPressed: () {
                    setState(() {
                      if (taskIndex < widget.routine.tasks.length - 1) {
                        taskIndex++;
                      }
                    });
                  },
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
