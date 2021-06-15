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
    _controller.getDataSensors();

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
              child: Text("Acelerômetro: ${_controller.accelerometer}"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Acelerômetro de Usuário: ${_controller.userAccelerometer}"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Giroscópio: ${_controller.gyroscope}"),
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
