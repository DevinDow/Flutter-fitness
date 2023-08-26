import 'package:fitness/move_library.dart';
import 'package:fitness/routine_library.dart';
import 'package:flutter/material.dart';

import 'routine.dart';

void main() {
  MoveLibrary.generate();
  RoutineLibrary.generate();
  runApp(const MyFitnessRoutines());
}

class MyFitnessRoutines extends StatelessWidget {
  const MyFitnessRoutines({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

class RoutineCategoryListView extends ListView {
  late final List<Routine> categoryRoutines = List.empty(growable: true);

  RoutineCategoryListView({
    super.key,
    required Categories category,
  }) {
    for (Routine routine in RoutineLibrary.routines.values) {
      if (routine.category == category) {
        categoryRoutines.add(routine);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categoryRoutines.length,
      itemBuilder: (context, index) {
        return RoutineTile(routine: categoryRoutines[index]);
      },
    );
  }
}

class RoutineTile extends ListTile {
  final Routine routine;

  const RoutineTile({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(routine.name),
        Text(routine.category.toString()),
      ],
    );
  }
}
