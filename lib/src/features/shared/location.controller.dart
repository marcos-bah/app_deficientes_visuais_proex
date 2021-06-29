import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:rx_notifier/rx_notifier.dart';

class LocationController {
  LocationController() {
    getLocation();
    location.getLocation().then((value) {
      inicio1 = value.latitude;
      inicio2 = value.longitude;
    });
  }

  //location plugin
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late var inicio1;
  late var inicio2;

  var locationData = RxNotifier<LocationData>(LocationData.fromMap({}));
  LocationData get getLocationData => locationData.value;

  void getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen(
      (LocationData currentLocation) {
        locationData.value = currentLocation;
      },
    );
  }

  var dist = RxNotifier<double>(0.0);

  void interval() {
    Timer.periodic(
      Duration(seconds: 5),
      (value) {
        dist.value = dist.value +
            Geolocator.distanceBetween(
              inicio1 ?? 0,
              inicio2 ?? 0,
              locationData.value.latitude ?? 0,
              locationData.value.longitude ?? 0,
            );
        inicio1 = locationData.value.latitude;
        inicio2 = locationData.value.longitude;
        print(dist.value);
      },
    );
  }
}
