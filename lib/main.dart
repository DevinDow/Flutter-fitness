import 'package:flutter/material.dart';

import 'routine.dart';

void main() {
  // build list of all Routines
  List<Routine> allRoutines = List<Routine>.generate(
      12,
      (i) => Routine(
          'Routine #$i', Categories.values[i % (Categories.max.index)]));

  runApp(MyFitnessRoutines(routines: allRoutines));
}

class MyFitnessRoutines extends StatelessWidget {
  final List<Routine> routines;

  const MyFitnessRoutines({super.key, required this.routines});

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
                Tab(text: "Fitness"),
                Tab(text: "Agility"),
                Tab(text: "Tai Chi"),
                Tab(text: "Meditation"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
