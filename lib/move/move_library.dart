// ignore_for_file: constant_identifier_names

import 'move.dart';
import '../pose/move_with_pose.dart';

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
    move.pose.torso.waist.y = 17;

    add(move);
  }
}
