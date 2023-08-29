import 'dart:ui';

import 'torso.dart';

class Pose {
  Torso? torso;

  Pose();

  void draw(Canvas canvas) {
    torso?.draw(canvas);
  }

  @override
  String toString() => '- $torso';
}
