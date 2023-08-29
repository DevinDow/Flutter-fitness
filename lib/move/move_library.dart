// ignore_for_file: constant_identifier_names

import 'move.dart';
import '../pose/move_with_pose.dart';
import '../pose/torso.dart';
import '../pose/leg.dart';
import '../pose/arm.dart';
import '../util/angle.dart';

class MoveLibrary {
  static Map<String, Move> moves = Map<String, Move>.identity();

  static void add(Move move) {
    moves[move.name] = move;
  }

  static void generate() {
    generateStandingFrontalMoves();
  }

  static const String MOUNTAIN_POSE = "Mountain Pose";

  static void generateStandingFrontalMoves() {
    MoveWithPose move = MoveWithPose(name: MOUNTAIN_POSE);

    move.pose.lLeg = Leg(proximalAngle: Angle.S + const Angle.degrees(3));
    move.pose.rLeg = Leg(proximalAngle: Angle.S - const Angle.degrees(3));
    move.pose.torso =
        Torso(waistY: move.pose.lLeg!.height + move.pose.lLeg!.thickness / 2);
    move.pose.lArm = Arm(proximalAngle: Angle.S + const Angle.degrees(2));
    move.pose.rArm = Arm(proximalAngle: Angle.S - const Angle.degrees(2));

    add(move);
  }
}
