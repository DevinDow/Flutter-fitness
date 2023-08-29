import '../util/angle.dart';

abstract class Appendage {
  // Fields
  Angle proximalAngle;
  double proximalLengthRatio;

  Angle distalAngle;
  double distalLengthRatio;

  // Properties
  double get thickness;
  double get segmentLength;

  // Constructor
  Appendage(
      {this.proximalAngle = Angle.S,
      this.proximalLengthRatio = 1.0,
      this.distalAngle = Angle.S,
      this.distalLengthRatio = 1.0});

  // Methods
}
