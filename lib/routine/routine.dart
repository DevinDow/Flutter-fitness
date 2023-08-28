import 'package:fitness/routine/task.dart';

enum Categories {
  none,
  stretch,
  warmup,
  yoga,
  taiChi,
  strength,
  cardio,
  meditation,
  soccer,
  agility,
  max,
}

class Routine {
  final String name;
  String description;
  Categories category;
  int totalMinutes = 11;
  bool ran = false;
  List<Task> tasks = List.empty(growable: true);

  Routine({
    required this.name,
    this.description = "",
    this.category = Categories.none,
  });
}