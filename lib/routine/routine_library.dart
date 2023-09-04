import 'routine.dart';
import 'task.dart';
import '../move/move_library.dart';

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
    routine.tasks.add(Task(moveName: MoveLibrary.MOUNTAIN_POSE));
    routine.tasks.add(Task(moveName: MoveLibrary.HIGH_KNEES));
    routine.tasks.add(Task(moveName: MoveLibrary.DONE));
    add(routine);

    routine = Routine(
        name: "Strength Test Routine",
        description: "description of Strength Test Routine",
        category: Categories.strength);
    routine.tasks.add(Task(moveName: MoveLibrary.MOUNTAIN_POSE));
    add(routine);
  }

  static void generateMorningYoga() {
    Routine routine = Routine(
      name: "Morning Yoga",
      description:
          "Yoga for getting going when stiff from inactivity.  Breathe with each movement.",
      category: Categories.warmup,
    );
    routine.tasks.add(Task(
        moveName: MoveLibrary.MOUNTAIN_POSE,
        instructions: "Roll up slowly.  Stand tall.  Breathe.",
        moveSeconds: 10,
        restSeconds: 5));
    add(routine);
  }
}
