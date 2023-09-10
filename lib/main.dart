import 'package:flutter/material.dart';

import 'move/move_library.dart';
import 'routine/routine_library.dart';
import 'routine/routine.dart';
import 'play/play_routine.dart';

void main() {
  MoveLibrary.generate(); // generate Library of Moves
  RoutineLibrary
      .generate(); // generate Library of Routines (which contain a series of Tasks/Moves)
  runApp(const MyFitnessRoutines());
}

/// Main Page Widget => a DefaultTabController
/// - Tabs for Categories of Routines
/// - each Tab has a ListView of Routines that match that Category
class MyFitnessRoutines extends StatelessWidget {
  const MyFitnessRoutines({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Fitness Routines",
      theme: ThemeData(
        primaryColor: Colors.blue,
        // https://api.flutter.dev/flutter/material/TextTheme-class.html
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 20, color: Colors.blueGrey),
        ),
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Fitness Routines'),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Warm-up"),
                Tab(text: "Strength"),
                Tab(text: "Agility"),
                Tab(text: "Tai Chi"),
                Tab(text: "Meditation"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              RoutineCategoryListView(category: Categories.warmup),
              RoutineCategoryListView(category: Categories.strength),
              RoutineCategoryListView(category: Categories.agility),
              RoutineCategoryListView(category: Categories.taiChi),
              RoutineCategoryListView(category: Categories.meditation),
            ],
          ),
        ),
      ),
    );
  }
}

/// ListViews of Routines for each Category Tab
class RoutineCategoryListView extends ListView {
  late final List<Routine> categoryRoutines = List.empty(growable: true);

  RoutineCategoryListView({super.key, required Categories category}) {
    for (Routine routine in RoutineLibrary.routines.values) {
      if (routine.category == category) {
        categoryRoutines.add(routine);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: categoryRoutines.length,
      itemBuilder: (context, index) {
        Routine routine = categoryRoutines[index];
        int duration = routine.totalMinutes;
        return ListTile(
          title: Text(routine.name),
          subtitle: Text(routine.description),
          leading: const Icon(Icons.accessibility),
          trailing: /*Column(children: [*/
              Text("$duration min"),
          /*routine.ran
                ? const Icon(Icons.check_circle_outline)
                : const Icon(Icons.circle_outlined),
          ]),*/
          onTap: () {
            // launch PlayRoutine Page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayRoutine(routine: routine)),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(color: Colors.black),
    );
  }
}
