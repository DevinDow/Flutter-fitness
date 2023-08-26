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
    add(Routine(name: "Test Routine 2", category: Categories.warmup));
    add(Routine(name: "Test Routine 3", category: Categories.strength));
  }

  static void generateTestRoutine() {
    Routine routine =
        Routine(name: "Test Routine", category: Categories.warmup);
    routine.tasks.add(Task(
        moveName: MoveLibrary.MOUNTAIN_POSE, moveSeconds: 10, restSeconds: 5));
    add(routine);
  }
}
