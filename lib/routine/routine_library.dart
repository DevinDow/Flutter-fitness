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

    generateMeditation(3);
    generateMeditation(5);
    generateMeditation(10);
  }

  static void generateTestRoutines() {
    Routine routine = Routine(
      name: "Test Routine",
      description: "description of Warm-up Test Routine",
      category: Categories.warmup,
    );
    routine.tasks.add(Task(
        moveName: MoveLibrary.MOUNTAIN_POSE, moveSeconds: 3, restSeconds: 2));
    routine.tasks.add(
        Task(moveName: MoveLibrary.HIGH_KNEES, moveSeconds: 5, restSeconds: 2));
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
        moveName: MoveLibrary.REST,
        instructions: "Breathe.",
        moveSeconds: 3,
        restSeconds: 2));
    add(routine);
  }

  static void generateMeditation(int minutes) {
    Routine routine = Routine(
      name: "$minutes' Meditation",
      description: "Meditation Timer",
      category: Categories.meditation,
    );
    routine.tasks.add(Task(
        moveName: MoveLibrary.REST,
        instructions: "Breathe.",
        moveSeconds: minutes * 60));
    add(routine);
  }
}
