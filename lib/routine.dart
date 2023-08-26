import 'package:fitness/task.dart';

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
  final Categories category;
  List<Task> tasks = List.empty(growable: true);

  Routine({
    required this.name,
    this.category = Categories.none,
  });
}
