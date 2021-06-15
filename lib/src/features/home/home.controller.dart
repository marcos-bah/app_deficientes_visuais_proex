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
  }

  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}
