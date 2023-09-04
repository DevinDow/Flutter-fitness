import 'dart:ui';
import 'package:flutter/material.dart';

import '../util/angle.dart';
import '../util/point.dart';

abstract class Appendage {
  // Fields
  Angle proximalAngle;
  double proximalLengthRatio;

  Angle distalAngle;
  double distalLengthRatio;

  // Properties
  double get thickness;
  double get segmentLength;
  double get height =>
      (proximalLengthRatio * segmentLength * proximalAngle.sin +
              distalLengthRatio * segmentLength * distalAngle.sin)
          .abs();

  // Constructor
  Appendage(
      {this.proximalAngle = Angle.S,
      this.proximalLengthRatio = 1.0,
      this.distalAngle = Angle.S,
      this.distalLengthRatio = 1.0});

  // Methods
  Point getProximalPoint(Point attachmentPoint) => Point(
      x: getProximalPointX(attachmentPoint.x),
      y: getProximalPointY(attachmentPoint.y));
  double getProximalPointX(double attachmentX) =>
      attachmentX + proximalLengthRatio * segmentLength * proximalAngle.cos;
  double getProximalPointY(double attachmentY) =>
      attachmentY + proximalLengthRatio * segmentLength * proximalAngle.sin;

  Point getDistalPoint(Point proximalPoint) => Point(
      x: getDistalPointX(proximalPoint.x), y: getDistalPointY(proximalPoint.y));
  double getDistalPointX(double proximalX) =>
      proximalX + distalLengthRatio * segmentLength * distalAngle.cos;
  double getDistalPointY(double proximalY) =>
      proximalY + distalLengthRatio * segmentLength * distalAngle.sin;

  void draw(Canvas canvas, Point attachmentPoint) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = thickness;

    Point proximalPoint = getProximalPoint(attachmentPoint);
    canvas.drawLine(
      attachmentPoint.offset,
      proximalPoint.offset,
      paint,
    );

    Point distalPoint = getDistalPoint(proximalPoint);
    canvas.drawLine(
      proximalPoint.offset,
      distalPoint.offset,
      paint,
    );

/*
    paint.color = Colors.green;
    canvas.drawCircle(attachmentPoint.offset, 2, paint);

    paint.color = Colors.red;
    canvas.drawCircle(proximalPoint.offset, 1, paint);

    paint.color = Colors.blue;
    canvas.drawCircle(distalPoint.offset, 1, paint);
*/
  }

  @override
  String toString() {
    String output = "";
    output += 'proximalAngle=$proximalAngle, ';
    output += 'distalAngle=$distalAngle, ';
    if (proximalLengthRatio != 1.0) {
      output += 'proximalLengthRatio=$proximalLengthRatio, ';
    }
    if (distalLengthRatio != 1.0) {
      output += 'distalLengthRatio=$distalLengthRatio';
    }
    return output;
  }
}
