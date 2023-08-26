import 'package:flutter/material.dart';

import 'routine.dart';

void main() {
  // build list of all Routines
  List<Routine> allRoutines = List<Routine>.generate(
      12,
      (i) => Routine(
            'Routine #$i',
            Categories.values[i % (Categories.max.index)],
          ));

  runApp(MyFitnessRoutines(allRoutines: allRoutines));
}

class MyFitnessRoutines extends StatelessWidget {
  final List<Routine> allRoutines;

  const MyFitnessRoutines({super.key, required this.allRoutines});

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
              RoutineCategoryListView(
                  category: Categories.warmup, allRoutines: allRoutines),
              RoutineCategoryListView(
                  category: Categories.strength, allRoutines: allRoutines),
              RoutineCategoryListView(
                  category: Categories.agility, allRoutines: allRoutines),
              RoutineCategoryListView(
                  category: Categories.taiChi, allRoutines: allRoutines),
              RoutineCategoryListView(
                  category: Categories.meditation, allRoutines: allRoutines),
            ],
          ),
        ),
      ),
    );
  }
}

class RoutineCategoryListView extends StatelessWidget /*ListView*/ {
  late final List<Routine> categoryRoutines = List.empty(growable: true);

  RoutineCategoryListView({
    super.key,
    required Categories category,
    required List<Routine> allRoutines,
  }) {
    for (Routine routine in allRoutines) {
      if (routine.category == category) {
        categoryRoutines.add(routine);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoutineTile(routine: categoryRoutines[0]);
    // ListView.builder();
  }
}

class RoutineTile extends StatelessWidget /*ListTile*/ {
  final Routine routine;

  const RoutineTile({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return Text(routine.name);
  }
}
