import 'package:pedometer/pedometer.dart';
import 'package:rx_notifier/rx_notifier.dart';

enum StepStatus { stopped, walking, error }

class StepController {
  var steps = RxNotifier<int>(0);
  int get getStep => steps.value;

  var status = RxNotifier<StepStatus>(StepStatus.stopped);
  StepStatus get getStatus => status.value;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  void onStepCount(StepCount event) {
    /// Handle step count changed
    steps.value = event.steps;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    /// Handle status changed
    String statusLocal = event.status;
    if (statusLocal == "walking") {
      status.value = StepStatus.walking;
    } else if (statusLocal == "stopped") {
      status.value = StepStatus.stopped;
    } else {
      status.value = StepStatus.error;
    }
  }

  void onPedestrianStatusError(error) {
    /// Handle the error
    print(error);
  }

  void onStepCountError(error) {
    /// Handle the error
    print(error);
  }

  Future<void> initPlatformState() async {
    /// Init streams
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _stepCountStream = Pedometer.stepCountStream;

    /// Listen to streams and handle errors
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
  }
}
