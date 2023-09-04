// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'move_library.dart';
import 'move.dart';

import 'dart:developer' as dev;

class MovePainter extends CustomPainter {
  // Fields
  late final Move? move;

  // Constants
  static const double BITMAP_INCHES = 90;
  static const double PIXELS_PER_INCH = 10;
  static const double BITMAP_PIXELS = BITMAP_INCHES * PIXELS_PER_INCH;

  // Constructor
  MovePainter({required moveName}) {
    move = MoveLibrary.moves[moveName];
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height); // Origi at floor center
    double scale = size.height / BITMAP_INCHES;
    canvas.scale(
        scale, scale); // Scale to Inches that the virtual window represents
    canvas.scale(1, -1); // up is positive Y

    if (move != null) {
      dev.log(move.toString(), name: "MovePainter");
      move?.paint(canvas);
    }
  }

  @override
  bool shouldRepaint(MovePainter oldDelegate) => true;
}
