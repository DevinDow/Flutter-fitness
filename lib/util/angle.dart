import 'dart:math' as math;
//import 'package:angles/angles.dart' as angles;
//import 'package:vector_math/vector_math.dart' as vector_math;

//import 'point.dart';

class Angle {
  // Fields
  final double radians;

  // Properties
  double get degrees => (radians / math.pi) * 180.0;
  double get sin => math.sin(radians);
  double get cos => math.cos(radians);
  double get tan => math.tan(radians);
  Angle get mirror => Angle.radians(math.pi - radians);
  Angle get opposite => Angle.radians(radians + math.pi);

  // Constants
  static const E = Angle.degrees(0);
  static const N = Angle.degrees(90);
  static const W = Angle.degrees(180);
  static const S = Angle.degrees(270);

  // Constructors
  const Angle.radians(this.radians);
  const Angle.degrees(final int degrees)
      : radians = 1.0 * degrees / 180.0 * math.pi;

  // Operators
  Angle operator +(final Angle other) => Angle.radians(radians + other.radians);
  Angle operator -(final Angle other) => Angle.radians(radians - other.radians);
  Angle operator -() => Angle.radians(-radians);

  // Overrides
  @override
  String toString() {
    double normalized = degrees;
    while (normalized < 0) {
      normalized += 360.0;
    }
    while (normalized >= 360.0) {
      normalized -= 360.0;
    }
    return "${normalized.toStringAsFixed(0)}°";
  }
}

/*class Angle {
  late final double radians;

  // Constants
  factory Angle.N() => Angle.degrees(90);

  // Constructors
  const Angle.radians(this.radians);

  const Angle.degrees(final int degrees) : radians = vector_math.radians(1.0 * degrees);

  Angle.fromDyDx({required double dy, required double dx}) {
    if (dy == 0 && dx == 0) {
      throw Exception("Angle can't be found from 0/0");
    }

    radians = angles.Angle.atan2(dy, dx).radians;
  }

  Angle.fromPoints({required Point p1, required Point p2}) {
    Angle.fromDyDx(dy: p2.y - p1.y, dx: p2.x - p1.x);
  }

  Angle.fromHeightsLength(
      {required double height1,
      required double height2,
      required double length}) {
    double dy = height2 - height1;
    radians = angles.Angle.asin(dy / length).radians;
  }
}
*/