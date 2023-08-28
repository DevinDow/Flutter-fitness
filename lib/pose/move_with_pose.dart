// ignore_for_file: constant_identifier_names

import 'package:angles/angles.dart';
import 'package:fitness/pose/torso.dart';
import 'package:flutter/material.dart';

import '../move/move.dart';
import 'pose.dart';

class MoveWithPose extends Move {
  // Fields
  Pose pose = Pose();

  // Constructors
  MoveWithPose({required super.name});

  // Methods
  @override
  void paint(Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill
      ..color = Colors.indigo;

    // Left eye
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(20, 40, 100, 100),
        const Radius.circular(20),
      ),
      paint,
    );

    // Right eye
    canvas.drawOval(
      const Rect.fromLTWH(150, 40, 100, 100),
      paint,
    );

    // Torso
    Torso torso = Torso(angle: const Angle.degrees(90));
    torso.draw(canvas, paint);
  }
}
