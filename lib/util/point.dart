import 'dart:ui';

class Point {
  double x;
  double y;

  Point({required this.x, required this.y});

  Offset get offset => Offset(x, y);

  @override
  String toString() => '(${x.toStringAsFixed(0)},${y.toStringAsFixed(0)})';
}
