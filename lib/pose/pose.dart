import 'dart:ui';

import 'torso.dart';

class Pose {
  Torso? torso;

  Pose();

  void draw(Canvas canvas, Paint paint) {
    torso?.draw(canvas, paint);
  }

  @override
  String toString() => '- $torso';
}
