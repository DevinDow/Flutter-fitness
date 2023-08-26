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

  Routine(this.name, this.category);
}

class Routines {
  static List<Routine> routines = List.empty(growable: true);

  static void generateRoutines() {
    routines.add(Routine("Test Routine", Categories.warmup));
  }
}
