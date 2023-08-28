import 'dart:ui';

import 'package:angles/angles.dart' as angles;

import '../util/point.dart';

class Torso {
  // Fields
  late final Offset waist;
  late final double lengthRatio;

  late final Offset collar;
  late final Offset head;

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
    required angles.Angle angle,
    bool isShoulderProfile = false,
    bool isHipsProfile = false,
  }) {
    // Waist
    waist = Offset(0, waistY);

    // Collar
    collar = Offset(
      length * lengthRatio * angle.cos,
      waistY + length + lengthRatio * angle.sin,
    );

    // Head
    double waistToHead = length * lengthRatio + thickness / 2 + headSize / 2;
    head = Offset(
      waistToHead * angle.cos,
      waistY + waistToHead * angle.sin,
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
    canvas.drawCircle(head, headSize / 2, paint);

    paint.strokeWidth = thickness;
    canvas.drawLine(waist, collar, paint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(20, 40, 100, 100),
        const Radius.circular(20),
      ),
      paint,
    );
  }
}
