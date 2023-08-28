import 'package:flutter/material.dart';

import 'move_library.dart';
import 'move.dart';

class MovePainter extends CustomPainter {
  late final Move? move;
  MovePainter({required moveName}) {
    move = MoveLibrary.moves[moveName];
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (move != null) {
      move?.paint(canvas);
    }
  }

  @override
  bool shouldRepaint(MovePainter oldDelegate) => false;
}
