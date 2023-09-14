import 'task.dart';

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
  bool ran = false;
  List<Task> tasks = List.empty(growable: true);

  int get totalMinutes {
    int totalSeconds = 0;
    for (Task task in tasks) {
      totalSeconds += task.moveSeconds + task.restSeconds;
    }
    return (totalSeconds / 60).ceil();
  }

  Routine({
    required this.name,
    this.description = "",
    this.category = Categories.none,
  });
}
