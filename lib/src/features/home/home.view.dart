import 'package:app_deficientes_visuais/src/features/home/home.controller.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer = _controller.accelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
    final gyroscope = _controller.gyroscopeValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
    final userAccelerometer = _controller.userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();

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
              child: Text("Acelerômetro: $accelerometer"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Acelerômetro de Usuário: $userAccelerometer"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Giroscópio: $gyroscope"),
            ),
            TextButton(
              onPressed: () {
                setState(
                  () {},
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
