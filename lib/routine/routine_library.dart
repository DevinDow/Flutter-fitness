import '../move/move_library.dart';
import 'routine.dart';
import 'task.dart';

class RoutineLibrary {
  static Map<String, Routine> routines = Map<String, Routine>.identity();

  static void add(Routine routine) {
    routines[routine.name] = routine;
  }

  static void generate() {
    generateTestRoutines();
    generateMorningYoga();
  }

  static void generateTestRoutines() {
    Routine routine = Routine(
      name: "Test Routine",
      description: "description of Warm-up Test Routine",
      category: Categories.warmup,
    );
    routine.tasks.add(Task(
        moveName: MoveLibrary.MOUNTAIN_POSE, moveSeconds: 10, restSeconds: 5));
    add(routine);

    add(Routine(
        name: "Strength Test Routine",
        description: "description of Strength Test Routine",
        category: Categories.strength));
  }

  static void generateMorningYoga() {
    Routine routine = Routine(
      name: "Morning Yoga",
      description:
          "Yoga for getting going when stiff from inactivity.  Breathe with each movement.",
      category: Categories.warmup,
    );
    routine.tasks.add(Task(
        moveName: MoveLibrary.MOUNTAIN_POSE, moveSeconds: 10, restSeconds: 5));
    add(routine);
  }
}
