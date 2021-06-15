import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class HomeController {
  List<double>? accelerometerValues;
  List<double>? userAccelerometerValues;
  List<double>? gyroscopeValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  var accelerometer;
  var gyroscope;
  var userAccelerometer;

  HomeController() {
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          gyroscopeValues = <double>[event.x, event.y, event.z];
        },
      ),
    );

    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          userAccelerometerValues = <double>[event.x, event.y, event.z];
        },
      ),
    );

    getDataSensors();
  }

  void getDataSensors() {
    accelerometer =
        accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    gyroscope =
        gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    userAccelerometer = userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
  }

  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}
