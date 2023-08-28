// ignore_for_file: constant_identifier_names

import 'package:fitness/move.dart';

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
    add(Move(name: "Mountain Pose"));
  }
}
