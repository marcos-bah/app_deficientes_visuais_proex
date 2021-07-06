import 'package:app_deficientes_visuais/src/features/step-count/step.view.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Deficientes Visuais - PROEX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StepView(),
    );
  }
}
