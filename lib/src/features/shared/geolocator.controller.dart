import 'package:geolocator/geolocator.dart';

class GeoController {
  GeoController() {
    init();
  }
  void init() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    /*await Geolocator.openAppSettings();
    await Geolocator.openLocationSettings();*/
  }

  double distance(
      double startLong, double startLat, double endLong, double endLat) {
    return Geolocator.distanceBetween(startLong, startLat, endLong, endLat);
  }

  double distanceContinua(
      double startLong, double startLat, var locationAtual) {
    return Geolocator.distanceBetween(
        startLong, startLat, locationAtual.longitude, locationAtual.latitude);
  }

  double bearing(
      double startLong, double startLat, double endLong, double endLat) {
    return Geolocator.bearingBetween(startLong, startLat, endLong, endLat);
  }
}
