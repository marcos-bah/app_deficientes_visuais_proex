import 'package:app_deficientes_visuais/src/features/home/home.controller.dart';
import 'package:app_deficientes_visuais/src/features/shared/location.controller.dart';
import 'package:app_deficientes_visuais/src/features/shared/sensors.controller.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Acelerômetro: ${_sensorsController.accelerometer}"),
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
                  "Location: ${_locationController.locationData.latitude} / ${_locationController.locationData.latitude}"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Acuracia: ${_locationController.locationData.accuracy} metros"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Alt: ${_locationController.locationData.altitude} metros"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Velocidade: ${_locationController.locationData.speed} m/s"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Acuracia Velocidade: ${_locationController.locationData.speedAccuracy} m/s "),
            ),
            TextButton(
              onPressed: () {
                setState(
                  () {
                    _locationController.getLocation();
                  },
                );
              },
              child: Text("Atualizar"),
            ),
          ],
        ),
      ),
    );
  }
}
