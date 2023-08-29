import 'dart:ui';

class Point {
  // Fields
  double x;
  double y;

  // Constructors
  Point({required this.x, required this.y});
  factory Point.offset(Point point, double dx, double dy) =>
      Point(x: point.x + dx, y: point.y + dy);

  // Properties
  Offset get offset => Offset(x, y);

  // Methods
  void shift(double dx, double dy) {
    x += dx;
    y += dy;
  }

  // Overrides
  @override
  String toString() => '(${x.toStringAsFixed(0)},${y.toStringAsFixed(0)})';
}
