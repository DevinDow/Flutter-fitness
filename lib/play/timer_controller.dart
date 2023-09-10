import 'dart:async';
import 'dart:developer' as dev;

class TimerController {
  Duration remaining;

  final Function() _onTick;
  final Function() _onFinished;

  Timer? _timer;

  bool get isRunning => _timer != null && _timer!.isActive;

  // Constructor
  TimerController({
    required this.remaining,
    required dynamic Function() onTick,
    required dynamic Function() onFinished,
  })  : _onFinished = onFinished,
        _onTick = onTick {
    dev.log("Constructor: $remaining", name: "TimerController");
  }

  // Methods
  void toggleTimer() {
    if (isRunning) {
      pauseTimer();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    dev.log("startTimer()", name: "TimerController");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      tick();
    });
  }

  void pauseTimer() {
    dev.log("pauseTimer()", name: "TimerController");
    _timer?.cancel();
  }

  void tick() {
    final seconds = remaining.inSeconds - 1; // count down

    if (seconds < 0) {
      dev.log("Finished", name: "TimerController");
      _onFinished.call();
    } else {
      remaining = Duration(seconds: seconds);
      dev.log("remaining = $remaining", name: "TimerController");
      _onTick.call();
    }
  }
}
