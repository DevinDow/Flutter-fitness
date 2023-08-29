import 'dart:ui';

import 'torso.dart';
import 'arm.dart';
import 'leg.dart';

class Pose {
  // Fields
  Torso? torso;

  Arm? rArm;
  Arm? lArm;
  Leg? rLeg;
  Leg? lLeg;

  // Constructors
  Pose();

  // Methods
  void draw(Canvas canvas) {
    if (torso != null) {
      torso!.draw(canvas);
      lArm?.draw(canvas, torso!.lShoulder);
      rArm?.draw(canvas, torso!.rShoulder);
      lLeg?.draw(canvas, torso!.lHip);
      rLeg?.draw(canvas, torso!.rHip);
    }
  }

  // Overrides
  @override
  String toString() => '- $torso';
}
