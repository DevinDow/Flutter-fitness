import 'appendage.dart';
import '../util/angle.dart';

class Arm extends Appendage {
  // Constants
  static const double armThickness = 4;
  static const double armSegmentLength = 12;

  // Properties
  @override
  double get thickness => armThickness;
  @override
  double get segmentLength => armSegmentLength;

  // Constructors
  Arm(
      {super.proximalAngle = Angle.S,
      super.proximalLengthRatio = 1.0,
      super.distalAngle = Angle.S,
      super.distalLengthRatio = 1.0});
}
