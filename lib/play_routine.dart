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
    return Scaffold(
      appBar: AppBar(
        title: Text(routine.name),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
