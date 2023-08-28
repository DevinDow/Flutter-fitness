import 'dart:ui';

import 'package:angles/angles.dart' as angles;

import '../util/point.dart';

class Torso {
  // Fields
  late final Point waist;
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
  static const thickness = 10;
  static const double length = 20;
  static const double lengthWithHead = length + headSize;
  //static const double distanceNeckToShoulder = thickness/2 + Arm.thickness/2;
  //static const double distanceWaistToHip = Leg.thickness/2 - 1;

  // Constructors
  Torso({
    double waistY = 0,
    this.lengthRatio = 1.0,
    required angles.Angle angle,
    bool isShoulderProfile = false,
    bool isHipsProfile = false,
  }) {
    // Waist
    waist = Point(y: waistY);

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
  void draw(Canvas canvas, Paint paint) {
    canvas.drawCircle(Offset(head.x, head.y), headSize, paint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(20, 40, 100, 100),
        const Radius.circular(20),
      ),
      paint,
    );
  }
}
