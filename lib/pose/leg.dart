import 'appendage.dart';

class Leg extends Appendage {
  static const double legThickness = 6;
  static const double legSegmentLength = 17;

  @override
  double get thickness => legThickness;
  @override
  double get segmentLength => legSegmentLength;
}
