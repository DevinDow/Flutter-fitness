import 'package:flutter/material.dart';

import 'routine.dart';
import 'task.dart';
import '../move/move_painter.dart';

class PlayRoutine extends StatelessWidget {
  final Routine routine;

  const PlayRoutine({
    super.key,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    Task task = routine.tasks[0];

    return Scaffold(
        appBar: AppBar(
          title: Text(routine.name),
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: LayoutBuilder(
                    builder: (_, constraints) => Container(
                      width: 300, //constraints.widthConstraints().maxWidth,
                      height: 300, //constraints.heightConstraints().maxHeight,
                      child: CustomPaint(
                          painter: MovePainter(moveName: task.moveName)),
                    ),
                  ),
                ),
              ),

              // Time
              Text(
                "1:00",
                style: textTheme.headlineMedium,
              ),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.skip_previous),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.play_arrow),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.skip_next),
                  ),
                ],
              ),

              // Next/Remaining
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Next: Down Dog",
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    "10 more = 4 min",
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
