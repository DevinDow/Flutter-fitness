import 'package:fitness/routine.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
        appBar: AppBar(
          title: Text(routine.name),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Move Name
              Text(
                routine.name,
                style: textTheme.headlineLarge,
              ),

              // Instructions
              Text(
                routine.description,
                style: textTheme.titleMedium,
              ),

              // Canvas
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: const SizedBox(
                  width: 300,
                  height: 300,
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
