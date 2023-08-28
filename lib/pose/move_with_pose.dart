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

    // Torso
    Torso torso = Torso(angle: const Angle.degrees(90));
    torso.draw(canvas, paint);
  }
}
