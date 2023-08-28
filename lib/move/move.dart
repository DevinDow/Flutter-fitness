import '../routine/routine.dart';

class Move {
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
}
