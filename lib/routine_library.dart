import 'routine.dart';

class RoutineLibrary {
  static Map<String, Routine> routines = Map<String, Routine>.identity();

  static void add(Routine routine) {
    routines[routine.name] = routine;
  }

  static void generate() {
    add(Routine(name: "Test Routine", category: Categories.warmup));
  }
}
