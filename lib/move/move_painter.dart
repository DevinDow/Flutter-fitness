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
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(1, -1);

    if (move != null) {
      move?.paint(canvas);
    }
  }

  @override
  bool shouldRepaint(MovePainter oldDelegate) => false;
}
