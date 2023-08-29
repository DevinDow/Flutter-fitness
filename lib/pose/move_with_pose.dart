// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../routine/routine.dart';
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

    pose.draw(canvas, paint);
  }

  @override
  String toString() =>
      'MoveWithPose = $name${category != Categories.none ? " of $category" : ""}${twoSides ? " twoSides " : ""}:\n$pose';
}
