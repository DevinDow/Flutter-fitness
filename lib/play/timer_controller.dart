import 'dart:async';
import 'dart:developer' as dev;

class TimerController {
  Duration remaining;

  Function()? onTick;
  Function()? onFinished;

  Timer? _timer;

  bool get isRunning => _timer != null && _timer!.isActive;

  // Constructor
  TimerController({
    this.remaining = const Duration(),
    this.onFinished,
  });

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => tick());
  }

  void pauseTimer() {
    dev.log("pauseTimer()", name: "TimerController");
    _timer?.cancel();
  }

  void tick() {
    final seconds = remaining.inSeconds - 1; // count down

    if (seconds < 0) {
      dev.log("Finished", name: "TimerController");
      onFinished?.call();
    } else {
      remaining = Duration(seconds: seconds);
      dev.log("Tick - remaining = $remaining", name: "TimerController");
      onTick?.call();
    }
  }
}
