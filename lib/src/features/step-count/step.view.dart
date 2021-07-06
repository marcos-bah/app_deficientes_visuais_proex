import 'package:app_deficientes_visuais/src/features/step-count/step.controller.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class StepView extends StatefulWidget {
  const StepView({Key? key}) : super(key: key);

  @override
  _StepViewState createState() => _StepViewState();
}

class _StepViewState extends State<StepView> {
  StepController controller = StepController();
  @override
  void initState() {
    super.initState();
    controller.initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contator de Passos",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                radius: 55,
                child: RxBuilder(
                  builder: (context) => Text(
                    controller.getStep.toString(),
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            RxBuilder(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  controller.getStatus.toString(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
        child: Text("Resetar"),
        onPressed: () {
          controller.steps.value = 0;
        },
      ),
    );
  }
}
