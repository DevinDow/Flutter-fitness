/// a Task of a Routine consists of a MoveName with Duration & Side
/// moveName is used to lookup in MoveLibrary
class Task {
  late final String moveName;
  String instructions;
  int moveSeconds;
  int restSeconds;
  //Side side

  Task({
    required this.moveName,
    this.instructions = "",
    this.moveSeconds = 1,
    this.restSeconds = 1,
    //this.Side =
  });
}
