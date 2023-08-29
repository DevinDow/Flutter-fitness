import 'dart:ui';

import '../util/point.dart';
import '../util/angle.dart';

class Torso {
  // Fields
  Point waist = Point(x: 0, y: 10);
  late final double lengthRatio;

  late final Point collar;
  late final Point head;

  /*Point[] points;

  Point rShoulder;
  Point lShoulder;

  Point rHip;
  Point lHip;

  bool mat = false;*/

  // Constants
  static const double headSize = 10;
  static const double thickness = 10;
  static const double length = 20;
  static const double lengthWithHead = length + headSize;
  //static const double distanceNeckToShoulder = thickness/2 + Arm.thickness/2;
  //static const double distanceWaistToHip = Leg.thickness/2 - 1;

  // Constructors
  Torso({
    double waistY = 0,
    this.lengthRatio = 1.0,
    Angle angle = Angle.N,
    bool isShoulderProfile = false,
    bool isHipsProfile = false,
  }) {
    // Waist
    waist = Point(x: 0, y: waistY);

    // Collar
    collar = Point(
      x: length * lengthRatio * angle.cos,
      y: waistY + length + lengthRatio * angle.sin,
    );

    // Head
    double waistToHead = length * lengthRatio + thickness / 2 + headSize / 2;
    head = Point(
      x: waistToHead * angle.cos,
      y: waistY + waistToHead * angle.sin,
    );

    /*
    // Shoulders
    if (isShoulderProfile) {
      rShoulder = collar.clone();
      lShoulder = collar.clone();
    } else {
      rShoulder = collar.offset(-distanceNeckToShoulder * angle.getSin(), distanceNeckToShoulder * angle.getCos());
      lShoulder = collar.offset(distanceNeckToShoulder * angle.getSin(), -distanceNeckToShoulder * angle.getCos());
    }

    // Hips
    if (isHipsProfile) {
      rHip = waist.clone();
      lHip = waist.clone();
    } else {
      rHip = waist.offset(-distanceWaistToHip * angle.getSin(), distanceWaistToHip * angle.getCos());
      lHip = waist.offset(distanceWaistToHip * angle.getSin(), -distanceWaistToHip * angle.getCos());
    }
    */
  }

  // Methods
  void draw(Canvas canvas) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawCircle(head.offset, headSize / 2, paint);

    paint.strokeWidth = thickness;
    canvas.drawLine(waist.offset, collar.offset, paint);
  }

  @override
  String toString() => 'Torso: waist=$waist, collar=$collar, head=$head';
}
