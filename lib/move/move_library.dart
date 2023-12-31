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
    generateStandingProfileMoves();
    generateSittingMoves();
  }

  static const String REST = "Rest";
  static const String DONE = "Done";
  static const String MOUNTAIN_POSE = "Mountain Pose";
  static const String HIGH_KNEES = "High Knees";

  static void generateStandingFrontalMoves() {
    MoveWithPose move = MoveWithPose(name: MOUNTAIN_POSE);
    Angle legAngle = Angle.S + const Angle.degrees(3);
    move.pose.lLeg = Leg.angles(legAngle);
    move.pose.rLeg = Leg.angles(legAngle.mirror);
    move.pose.torso =
        Torso(waistY: move.pose.lLeg!.height + move.pose.lLeg!.thickness / 2);
    Angle armAngle = Angle.S + const Angle.degrees(2);
    move.pose.lArm = Arm.angles(armAngle);
    move.pose.rArm = Arm.angles(armAngle.mirror);
    add(move);

    move = MoveWithPose(name: DONE);
    legAngle = Angle.S + const Angle.degrees(6);
    move.pose.lLeg = Leg.angles(legAngle);
    move.pose.rLeg = Leg.angles(legAngle.mirror);
    move.pose.torso =
        Torso(waistY: move.pose.lLeg!.height + move.pose.lLeg!.thickness / 2);
    Angle armProximalAngle = Angle.W - const Angle.degrees(30);
    Angle armDistalAngle = Angle.N + const Angle.degrees(10);
    move.pose.rArm =
        Arm(proximalAngle: armProximalAngle, distalAngle: armDistalAngle);
    move.pose.lArm = Arm(
        proximalAngle: armProximalAngle.mirror,
        distalAngle: armDistalAngle.mirror);
    add(move);
  }

  static void generateStandingProfileMoves() {
    MoveWithPose move = MoveWithPose(name: HIGH_KNEES);
    move.pose.lLeg = Leg(
        proximalAngle: Angle.S + const Angle.degrees(10),
        distalAngle: Angle.S - const Angle.degrees(10));
    move.pose.rLeg = Leg(
        proximalAngle: Angle.E + const Angle.degrees(10), distalAngle: Angle.S);
    move.pose.torso = Torso(
        isShoulderProfile: true,
        isHipsProfile: true,
        waistY: move.pose.lLeg!.height + move.pose.lLeg!.thickness / 2);
    add(move);
  }

  static void generateSittingMoves() {
    MoveWithPose move = MoveWithPose(name: REST);
    move.pose.torso = Torso(waistY: Torso.thickness / 2);
    Angle legProxAngle = Angle.W - const Angle.degrees(10);
    Angle legDistAngle = Angle.E - const Angle.degrees(20);
    move.pose.rLeg = Leg(
        proximalAngle: legProxAngle,
        proximalLengthRatio: 0.8,
        distalAngle: legDistAngle,
        distalLengthRatio: 0.8);
    move.pose.lLeg = Leg(
        proximalAngle: legProxAngle.mirror,
        proximalLengthRatio: 0.8,
        distalAngle: legDistAngle.mirror,
        distalLengthRatio: 0.8);
    Angle armProximalAngle = Angle.S - const Angle.degrees(5);
    Angle armDistalAngle = Angle.W + const Angle.degrees(15);
    move.pose.rArm = Arm(
        proximalAngle: armProximalAngle,
        distalAngle: armDistalAngle,
        distalLengthRatio: 0.8);
    move.pose.lArm = Arm(
        proximalAngle: armProximalAngle.mirror,
        distalAngle: armDistalAngle.mirror,
        distalLengthRatio: 0.8);
    add(move);
  }
}
