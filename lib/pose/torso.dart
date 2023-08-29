import 'dart:ui';

import 'package:flutter/material.dart';

import '../util/point.dart';
import '../util/angle.dart';
import 'arm.dart';
import 'leg.dart';

class Torso {
  // Fields
  Point waist = Point(x: 0, y: 10);
  late final double lengthRatio;

  late final Point collar;
  late final Point head;

  late final List<Point> points;

  late final Point rShoulder;
  late final Point lShoulder;

  late final Point rHip;
  late final Point lHip;

  bool mat = false;

  // Constants
  static const double headSize = 10;
  static const double thickness = 10;
  static const double length = 20;
  static const double lengthWithHead = length + headSize;
  static const double distanceNeckToShoulder =
      thickness / 2 + Arm.armThickness / 2;
  static const double distanceWaistToHip = Leg.legThickness / 2 - 1;

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

    // Shoulders
    if (isShoulderProfile) {
      rShoulder = collar;
      lShoulder = collar;
    } else {
      rShoulder = Point.offset(
        collar,
        -distanceNeckToShoulder * angle.sin,
        distanceNeckToShoulder * angle.cos,
      );
      lShoulder = Point.offset(
        collar,
        distanceNeckToShoulder * angle.sin,
        -distanceNeckToShoulder * angle.cos,
      );
    }

    // Hips
    if (isHipsProfile) {
      rHip = waist;
      lHip = waist;
    } else {
      rHip = Point.offset(
        waist,
        -distanceWaistToHip * angle.sin,
        distanceWaistToHip * angle.cos,
      );
      lHip = Point.offset(
        waist,
        distanceWaistToHip * angle.sin,
        -distanceWaistToHip * angle.cos,
      );
    }
  }

  // Methods
  void draw(Canvas canvas) {
    final paint = Paint()
      //..style = PaintingStyle.stroke
      //..strokeWidth = 0.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawCircle(head.offset, headSize / 2, paint);

    paint.strokeWidth = thickness;
    canvas.drawLine(waist.offset, collar.offset, paint);
/*
    paint.color = Colors.green;
    canvas.drawCircle(head.offset, 1, paint);

    paint.color = Colors.red;
    canvas.drawCircle(collar.offset, 1, paint);

    paint.color = Colors.blue;
    canvas.drawCircle(lShoulder.offset, 1, paint);
    canvas.drawCircle(rShoulder.offset, 1, paint);

    paint.color = Colors.blue;
    canvas.drawCircle(lHip.offset, 1, paint);
    canvas.drawCircle(rHip.offset, 1, paint);*/
  }

  // Overrides
  @override
  String toString() => 'Torso: waist=$waist, collar=$collar, head=$head';
}
