import 'move_library.dart';
import 'routine.dart';
import 'task.dart';

class RoutineLibrary {
  static Map<String, Routine> routines = Map<String, Routine>.identity();

  static void add(Routine routine) {
    routines[routine.name] = routine;
  }

  static void generate() {
    generateTestRoutine();
    add(Routine(
        name: "Warm-up Test Routine 2",
        description: "description of Warm-up Test Routine #2",
        category: Categories.warmup));
    add(Routine(
        name: "Warm-up Test Routine 3",
        description: "description of Warm-up Test Routine #3",
        category: Categories.warmup));
    add(Routine(
        name: "Strength Test Routine",
        description: "description of Strength Test Routine",
        category: Categories.strength));
  }

  static void generateTestRoutine() {
    Routine routine = Routine(
      name: "Test Routine",
      description: "description of Warm-up Test Routine",
      category: Categories.warmup,
    );
    routine.tasks.add(Task(
        moveName: MoveLibrary.MOUNTAIN_POSE, moveSeconds: 10, restSeconds: 5));
    add(routine);
  }
}
