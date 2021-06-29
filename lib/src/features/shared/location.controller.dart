import 'package:location/location.dart';

class LocationController {
  LocationController() {
    location.getLocation().then((value) => locationData = value);
    getLocation();
  }

  //location plugin
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  // ignore: unused_field
  LocationData locationData = LocationData.fromMap({});

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
        locationData = currentLocation;

        print(currentLocation.accuracy);
        print(currentLocation.altitude);
        print(currentLocation.satelliteNumber);
        print(currentLocation.verticalAccuracy);
      },
    );
  }
}
