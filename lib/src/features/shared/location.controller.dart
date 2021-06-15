import 'package:location/location.dart';

class LocationController {
  LocationController();

  //location plugin
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  // ignore: unused_field
  late LocationData _locationData;
  late LocationData locationData;

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

    _locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      locationData = currentLocation;
      print(currentLocation);
    });
  }
}
