import 'package:flutter/material.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/values/routes.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_rounded),
        onPressed: () {
          pvSettingsLogic.hasCompletedOnboarding.value = true;
          pvNavService.pushReplacementNamed(loginRoute);
        },
      ),
      body: Center(
        child: Text('There will be an awesome thing here.'),
      ),
    );
  }
}
