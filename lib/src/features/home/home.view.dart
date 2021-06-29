import 'package:app_deficientes_visuais/src/features/home/home.controller.dart';
import 'package:app_deficientes_visuais/src/features/shared/geolocator.controller.dart';
import 'package:app_deficientes_visuais/src/features/shared/location.controller.dart';
import 'package:app_deficientes_visuais/src/features/shared/sensors.controller.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: unused_field
  late HomeController _controller;
  late LocationController _locationController;
  late SensorsController _sensorsController;
  late GeoController _geoController;
  late var inicioLat;
  late var inicioLong;
  var distancia = RxNotifier<double>(0.0);

  @override
  void dispose() {
    super.dispose();
    _sensorsController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
    _locationController = LocationController();
    _sensorsController = SensorsController();
    _geoController = GeoController();
    _locationController.interval();
  }

  @override
  Widget build(BuildContext context) {
    _sensorsController.getDataSensor();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: RxBuilder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Acelerômetro: ${_sensorsController.accelerometer}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Acelerômetro de Usuário: ${_sensorsController.userAccelerometer}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Giroscópio: ${_sensorsController.gyroscope}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Location: ${_locationController.getLocationData.latitude} / ${_locationController.getLocationData.latitude}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Acuracia: ${_locationController.getLocationData.accuracy?.toStringAsFixed(2)} metros"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Alt: ${_locationController.getLocationData.altitude?.toStringAsFixed(2)} metros"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Velocidade: ${_locationController.getLocationData.speed?.toStringAsFixed(2)} m/s"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Acuracia Velocidade: ${_locationController.getLocationData.speedAccuracy?.toStringAsFixed(2)} m/s "),
                  ),
                  TextButton(
                      onPressed: () {
                        inicioLat =
                            _locationController.getLocationData.latitude;
                        inicioLong =
                            _locationController.getLocationData.longitude;
                      },
                      child: Text("inicio")),
                  TextButton(
                      onPressed: () {
                        distancia.value = _geoController.distance(
                          inicioLong,
                          inicioLat,
                          _locationController.getLocationData.longitude ?? 0,
                          _locationController.getLocationData.latitude ?? 0,
                        );
                      },
                      child: Text("fim")),
                  Text(
                      "${_locationController.dist.value.toStringAsFixed(2)} metros"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
