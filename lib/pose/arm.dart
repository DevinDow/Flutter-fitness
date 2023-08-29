import 'appendage.dart';

class Arm extends Appendage {
  static const double armThickness = 4;
  static const double armSegmentLength = 12;

  @override
  double get thickness => armThickness;
  @override
  double get segmentLength => armSegmentLength;
}
