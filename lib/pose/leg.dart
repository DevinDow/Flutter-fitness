import 'appendage.dart';
import '../util/angle.dart';

class Leg extends Appendage {
  // Constants
  static const double legThickness = 6;
  static const double legSegmentLength = 17;

  // Properties
  @override
  double get thickness => legThickness;
  @override
  double get segmentLength => legSegmentLength;

  // Constructors
  Leg(
      {super.proximalAngle = Angle.S,
      super.proximalLengthRatio = 1.0,
      super.distalAngle = Angle.S,
      super.distalLengthRatio = 1.0});

  Leg.angles(Angle angles) {
    proximalAngle = distalAngle = angles;
  }
}
