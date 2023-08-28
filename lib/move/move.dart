import 'package:flutter/material.dart';

import '../routine/routine.dart';

abstract class Move {
  late final String name;
  String description;
  Categories category;
  bool twoSides;

  Move({
    required this.name,
    this.description = "",
    this.category = Categories.none,
    this.twoSides = false,
  });

  void paint(Canvas canvas);
}
