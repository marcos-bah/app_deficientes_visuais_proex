import 'dart:async';

import 'package:rx_notifier/rx_notifier.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsController {
  var accelerometerValues = RxList<double>([]);
  var userAccelerometerValues = RxList<double>([]);
  var gyroscopeValues = RxList<double>([]);
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  var accelerometer = RxList<String>([]);
  var gyroscope = RxList<String>([]);
  var userAccelerometer = RxList<String>([]);

  SensorsController() {
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          gyroscopeValues = <double>[event.x, event.y, event.z].asRx();
          getDataSensor();
        },
      ),
    );

    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          userAccelerometerValues = <double>[event.x, event.y, event.z].asRx();
          getDataSensor();
        },
      ),
    );

    getDataSensor();
  }

  void getDataSensor() {
    accelerometer = accelerometerValues
        .map((double v) => v.toStringAsFixed(1))
        .toList()
        .asRx();
    gyroscope =
        gyroscopeValues.map((double v) => v.toStringAsFixed(1)).toList().asRx();
    userAccelerometer = userAccelerometerValues
        .map((double v) => v.toStringAsFixed(1))
        .toList()
        .asRx();
  }

  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}
