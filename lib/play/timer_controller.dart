import 'package:flutter/material.dart';

class TimerController extends ChangeNotifier {
  late Duration duration;
  /*Duration get duration => _duration;
  set duration(Duration newDuration) {
    _duration = newDuration;
    reset();
  }*/

  final Function() onFinished;

  // Constructor
  TimerController({
    required this.duration,
    required this.onFinished,
  });

  // Methods
  /// Timer reset function.
  void reset() {
    //_state.value = CustomTimerState.reset;
    notifyListeners();
  }

  /// Timer start function.
  void start() {
    //_state.value = CustomTimerState.counting;
    notifyListeners();
  }

  void _pause() {
    //_state.value = CustomTimerState.paused;
    notifyListeners();
  }

  /// Timer pause function.
  void pause() {
    //if (state.value != CustomTimerState.counting) return;
    _pause();
  }

  /// Timer finish function.
  void finish() {
    //_state.value = CustomTimerState.finished;
    notifyListeners();
  }
}
