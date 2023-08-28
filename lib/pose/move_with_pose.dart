import '../move/move.dart';
import 'pose.dart';

class MoveWithPose extends Move {
  Pose pose = Pose();

  MoveWithPose({required super.name});
}
